FROM debian:stable-slim
# Install build dependencies
RUN apt-get update && apt-get install -y \
		openssh-client \
		curl \
		vim \
		jq \
		dpkg \
		git \
		unzip

# Get Terraform
ARG TF_VERSION=1.3.7
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
ARG TG_VERSION=v0.43.0
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
	&& curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
	&& unzip awscliv2.zip \
	&& ./aws/install && \
	rm -rf aws* terra*

WORKDIR /data
CMD ["/bin/bash"]
