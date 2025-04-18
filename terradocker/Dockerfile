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
		python3-pip

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
	fi \
	&& curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWSCLI_ARCH}.zip" -o "awscliv2.zip" \
	&& unzip awscliv2.zip \
	&& ./aws/install \
	&& rm -rf aws* terra* \
    && mkdir -p /root/.aws \
	# install Node.js and NPM for some Projects which require Node.js and NPM
	&& curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && apt-get install -y nodejs

WORKDIR /data
CMD ["/bin/bash"]
