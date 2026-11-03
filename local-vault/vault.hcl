ui = true
disable_mlock = true
api_addr = "https://localhost:8200"
cluster_addr = "https://127.0.0.1:8201"

storage "raft" {
  path = "/vault/data"
  node_id = "local-vault"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  cluster_address = "127.0.0.1:8201"
  tls_disable = false
  tls_min_version = "tls12"
  tls_cert_file = "/vault/tls/vault.crt"
  tls_key_file = "/vault/tls/vault.key"
}