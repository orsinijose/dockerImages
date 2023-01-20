FROM node:18.12.1-slim

WORKDIR /var/www/html/

RUN apt-get update && apt-get install -y jq ssh curl vim && \
npm install -g npm@9.1.2 && \
npm install -g serverless@3.25.1 && \
npm install -g depcheck

USER root

WORKDIR /data

CMD ["/bin/bash"]
