FROM node:22-slim

RUN apt-get update && apt-get install -y jq ssh curl vim zip unzip git python3-pip \
	&& npm install -g npm@latest \
	&& npm install -g serverless@latest \
	&& npm install -g depcheck \
	&& ARCH=$(uname -m) \
	&& if [ "$ARCH" = "x86_64" ]; then AWSCLI_ARCH="x86_64"; \
	   elif [ "$ARCH" = "aarch64" ]; then AWSCLI_ARCH="aarch64"; \
	   elif [ "$ARCH" = "armv7l" ]; then AWSCLI_ARCH="armv7l"; \
	   else AWSCLI_ARCH="x86_64"; fi \
	&& curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}.zip" -o "awscliv2.zip" \
	&& unzip awscliv2.zip  \
	&& ./aws/install \
	&& rm -rf aws* \
	&& mkdir -p /root/.aws

RUN useradd -ms /bin/bash nodelocaluser \
&& mkdir -p /home/nodelocaluser/.aws \
&& chown -R nodelocaluser:nodelocaluser /home/nodelocaluser/.aws \
&& chown -R nodelocaluser:nodelocaluser /usr/local/bin/aws \
&& chown -R nodelocaluser:nodelocaluser /usr/local/bin/node \
&& chown -R nodelocaluser:nodelocaluser /usr/local/bin/npm \
&& chown -R nodelocaluser:nodelocaluser /usr/local/bin/serverless \
&& node --version \
&& aws --version \
&& npm --version \
&& serverless --version \
&& python3 --version

USER nodelocaluser

WORKDIR /home/nodelocaluser

CMD ["/bin/bash"]
