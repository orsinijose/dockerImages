# Local Vault

Single-node Vault with HTTPS, the web UI, and persistent Raft storage. This
is not dev mode: initialize once and manually unseal after each restart.
Certificates and credentials are never included in the image.

## Certificates

`mkcert` supports macOS, Windows, and Linux. Run certificate-generation commands
from this directory. The `-install` step adds a local CA to your host trust
store and may request administrator approval. Restart your browser afterward.
Firefox may require separate trust configuration, particularly on Windows;
never bypass browser certificate warnings.

### Install mkcert

macOS (Homebrew):

```sh
brew install mkcert
brew install nss
```

`nss` enables Firefox trust-store integration on macOS.

Windows (Chocolatey, from an elevated PowerShell terminal):

```powershell
choco install mkcert -y
```

Reopen a normal PowerShell terminal after installation. Alternatively, use
`scoop bucket add extras` followed by `scoop install mkcert`, or download the
Windows executable from the [official releases](https://github.com/FiloSottile/mkcert/releases).

Ubuntu/Debian, where the distribution provides the `mkcert` package:

```sh
sudo apt update
sudo apt install mkcert libnss3-tools ca-certificates
```

Fedora, where the enabled repositories provide `mkcert`:

```sh
sudo dnf install mkcert nss-tools ca-certificates
```

Arch Linux:

```sh
sudo pacman -Syu mkcert nss ca-certificates
```

For other distributions, including RHEL/Rocky installations without a `mkcert`
package, follow the [upstream Linux installation instructions](https://github.com/FiloSottile/mkcert#linux).
Choose a binary matching your CPU architecture. Install `nss-tools` on
RHEL-compatible systems or `mozilla-nss-tools` on openSUSE for browser trust
integration. Keep certificate generation under your normal user account;
do not run the entire workflow with `sudo`.

### Generate On macOS Or Linux

```sh
mkcert -install
umask 077
mkdir -p tls
chmod 0700 tls
mkcert -cert-file tls/vault.crt -key-file tls/vault.key localhost 127.0.0.1 ::1
cp "$(mkcert -CAROOT)/rootCA.pem" tls/ca.crt
chmod 0600 tls/vault.key
```

### Generate On Windows

Run in PowerShell on an NTFS filesystem. Restrict the certificate directory to
your account before creating the private key:

```powershell
mkcert -install
New-Item -ItemType Directory -Force -Path .\tls | Out-Null
$identity = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
icacls .\tls /inheritance:r /grant:r "${identity}:(OI)(CI)F"
if ($LASTEXITCODE -ne 0) { throw "Unable to secure the TLS directory" }
mkcert -cert-file .\tls\vault.crt -key-file .\tls\vault.key localhost 127.0.0.1 ::1
$caRoot = mkcert -CAROOT
Copy-Item -LiteralPath (Join-Path $caRoot "rootCA.pem") -Destination .\tls\ca.crt
```

Use a new private directory if an existing `tls` directory has explicit grants
to other users; disabling inheritance does not remove existing explicit grants.
The Docker certificate-copy container below sets the separate Linux volume
permissions; Windows does not need `chmod`.

WSL has a separate trust store. Running `mkcert -install` only inside WSL does
not automatically trust its CA in Windows browsers. Generate certificates with
Windows `mkcert` for Windows browsers, or explicitly import the WSL CA's public
certificate into Windows's Trusted Root Certification Authorities store.

Keep the mkcert CA private key on the host; do not mount it in Vault or
commit it. Only the server key and public certificates go into the TLS volume.

## Build And Start

The commands below use Bash syntax. On Windows, use WSL with Docker Desktop's
Linux-container integration enabled, and change to this directory containing
the generated `tls` files. PowerShell does not use `\` for line continuation.

```sh
docker build --pull -t local-vault:2.2.1 .
docker volume create local-vault-data
docker volume create local-vault-logs
docker volume create local-vault-tls

docker run --rm --user 0 --entrypoint sh \
  --mount type=bind,src="$PWD/tls",dst=/certificates,readonly \
  --mount type=volume,src=local-vault-tls,dst=/vault/tls \
  local-vault:2.2.1 -ec '
    cp /certificates/ca.crt /certificates/vault.crt /certificates/vault.key /vault/tls/
    chown -R vault:vault /vault/tls
    chmod 0700 /vault/tls
    chmod 0644 /vault/tls/ca.crt /vault/tls/vault.crt
    chmod 0600 /vault/tls/vault.key
  '

docker run -d --name local-vault --restart unless-stopped \
  --cap-drop ALL --security-opt no-new-privileges=true --read-only \
  --tmpfs /tmp:rw,noexec,nosuid,size=64m \
  --publish 127.0.0.1:8200:8200 \
  --mount type=volume,src=local-vault-data,dst=/vault/data \
  --mount type=volume,src=local-vault-logs,dst=/vault/logs \
  --mount type=volume,src=local-vault-tls,dst=/vault/tls,readonly \
  local-vault:2.2.1
```

The server runs as `vault`, with no Linux capabilities. Raft uses memory-mapped
storage, so `disable_mlock = true` is intentional. Disable swap on the Docker
Linux host/VM, or use encrypted swap, to protect sensitive memory at rest.
Protect the host and Docker daemon: anyone controlling Docker can access these
volumes. This is a local setup, not a highly available production deployment.

## Initialize And Access

Open <https://localhost:8200/ui/> to initialize with five key shares and a
threshold of three, or run the following yourself in a private terminal:

```sh
docker exec -it local-vault vault operator init -key-shares=5 -key-threshold=3
docker exec -it local-vault vault operator unseal
```

The initialization output contains sensitive unseal keys and the initial root
token. Store them securely and separately from the data volume. Run `unseal`
three times, entering a different share at each hidden prompt. Never put keys
or tokens into command arguments, Docker environment variables, or Git.

Use the root token only to bootstrap policies, a normal authentication method
(such as userpass or OIDC), and a persistent audit device. Revoke the initial
root token after verifying a non-root administrator can log in. The UI supports
login and unsealing over HTTPS. For a host-installed Vault CLI:

```sh
export VAULT_ADDR=https://localhost:8200
export VAULT_CACERT="$PWD/tls/ca.crt"
vault status
vault login
```

`vault login` prompts for a token and normally caches it on the host; protect
your home directory or use `vault login -no-store` to avoid caching it.
The bundled CLI also supports `docker exec -it local-vault vault status`.
Do not set `VAULT_SKIP_VERIFY` or use `curl -k`.

Docker health is unhealthy until Vault is initialized and unsealed. After a
restart, repeat unsealing, not initialization. Back up Raft snapshots and keep
unseal shares separately; deleting the data volume destroys stored secrets.
After certificate renewal, refresh the TLS volume and restart the container.
Review Vault security advisories and update the pinned version regularly.