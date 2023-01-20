FROM node:18.12.1-slim

RUN apt-get update && apt-get install -y jq ssh curl vim jq zip unzip && \
npm install -g npm@9.3.1 && \
npm install -g serverless@latest && \
npm install -g depcheck && \
curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
./aws/install && \
rm -rf aws

USER root

WORKDIR /data

CMD ["/bin/bash"]
