FROM node:18.12.1-slim

RUN apt-get update && apt-get install -y jq ssh curl vim jq zip unzip git python3-pip\
&& npm install -g npm@9.3.1 \
&& npm install -g serverless@latest \
&& npm install -g depcheck \
\
&& if [ "$(dpkg --print-architecture | awk -F'-' '{print $NF}' )" = "i386" ]; then\
		ARCH=386; \
	elif [ "$(uname -m)" = "x86_64" ]; then \
		ARCH=amd64; \
	elif [ "$(uname -m)" = "aarch64" ]; then \
		ARCH=arm64; \
	elif [ "$(uname -m)" = "armv7l" ]; then \
		ARCH=arm; \
	fi \
	\
&& if [ "${ARCH}" = "arm" ] | [ "${ARCH}" = "arm64" ]; then \
    AWSCLI_ARCH="aarch64"; \
else \
    AWSCLI_ARCH="x86_64"; \
fi \
&& curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip  \
&& ./aws/install \
&& rm -rf aws* \
&& mkdir -p /root/.aws

USER root

WORKDIR /data

CMD ["/bin/bash"]
