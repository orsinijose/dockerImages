ARG VAULT_VERSION=2.2.1
FROM hashicorp/vault:${VAULT_VERSION}

USER root
RUN mkdir -p /vault/data /vault/logs /vault/tls \
	&& chown vault:vault /vault/data /vault/logs /vault/tls \
	&& chmod 0700 /vault/data /vault/logs /vault/tls

COPY --chown=vault:vault --chmod=0444 vault.hcl /vault/config/vault.hcl

ENV VAULT_ADDR=https://localhost:8200 \
	VAULT_CACERT=/vault/tls/ca.crt

USER vault
VOLUME ["/vault/data", "/vault/logs"]
EXPOSE 8200

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
	CMD vault status >/dev/null 2>&1 || exit 1

ENTRYPOINT ["vault"]
CMD ["server", "-config=/vault/config/vault.hcl"]
