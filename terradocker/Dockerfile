FROM debian:stable-slim
# Install build dependencies
RUN apt-get update && apt-get install -y \
		openssh-client \
		curl \
		vim \
		jq \
		dpkg \
		git \
		unzip \
		python3-pip \
		openssl \
		libc6-dev

# Get Terraform
ARG TF_VERSION=1.11.4
RUN if [ "$(dpkg --print-architecture | awk -F'-' '{print $NF}' )" = "i386" ]; then\
		ARCH=386; \
	elif [ "$(uname -m)" = "x86_64" ]; then \
		ARCH=amd64; \
	elif [ "$(uname -m)" = "aarch64" ]; then \
		ARCH=arm64; \
	elif [ "$(uname -m)" = "armv7l" ]; then \
		ARCH=arm; \
	fi \
	&& curl --fail -sS -L -O \
		https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_${ARCH}.zip \
	&& unzip terraform_${TF_VERSION}_linux_${ARCH}.zip \
	&& mv terraform /usr/bin/terraform \
	&& chmod +x /usr/bin/terraform

# Get Terragrunt
ARG TG_VERSION=v0.77.19
RUN if [ "$(dpkg --print-architecture | awk -F'-' '{print $NF}' )" = "i386" ]; then\
		ARCH=386; \
	elif [ "$(uname -m)" = "x86_64" ]; then \
		ARCH=amd64; \
	elif [ "$(uname -m)" = "aarch64" ]; then \
		ARCH=arm64; \
	elif [ "$(uname -m)" = "armv7l" ]; then \
		ARCH=arm; \
	fi \
	\
	&& curl --fail -sS -L \
		https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_${ARCH} \
		-o /usr/bin/terragrunt \
	&& chmod +x /usr/bin/terragrunt \
	\
	&& terraform --version \
	&& terragrunt --version \
	\
	&& if [ "${ARCH}" = "arm" ] | [ "${ARCH}" = "arm64" ]; then \
	  AWSCLI_ARCH="aarch64"; \
	else \
      AWSCLI_ARCH="x86_64"; \
	fi

# Install AWS CLI
RUN if [ "${ARCH}" = "arm" ] || [ "${ARCH}" = "arm64" ]; then \
AWSCLI_ARCH="aarch64"; \
else \
AWSCLI_ARCH="x86_64"; \
fi \
&& curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&& ./aws/install \
&& rm -rf aws* terra* \
&& mkdir -p /root/.aws

# Install Node.js and NPM
ARG NODE_VERSION=22
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& apt-get install -y nodejs

# Add a non-root user to run the container
RUN useradd -ms /bin/bash terradocker \
&& mkdir -p /home/terradocker/.aws \
&& chown -R terradocker:terradocker /home/terradocker/.aws \
&& chown -R terradocker:terradocker /usr/bin/terraform \
&& chown -R terradocker:terradocker /usr/bin/terragrunt \
&& chown -R terradocker:terradocker /usr/local/bin/aws \
&& chown -R terradocker:terradocker /usr/local/aws-cli \
&& chown -R terradocker:terradocker /usr/bin/node \
&& chown -R terradocker:terradocker /usr/bin/npm \
&& terraform --version \
&& terragrunt --version \
&& node --version \
&& aws --version \
&& npm --version 

USER terradocker

# Set the default working directory
WORKDIR /home/terradocker

CMD ["/bin/bash"]
