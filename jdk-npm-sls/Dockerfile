FROM anapsix/alpine-java:8_jdk
LABEL maintainer="Jose Orsini <orsini.jose@gmail.com>"

ARG API_PORT=3000
ARG SERVERLESS_VERSION=1.48.4

RUN apk --no-cache update && \
    apk add python-dev curl 
RUN apk --no-cache update && apk add nodejs nodejs-npm
RUN npm install -g serverless@${SERVERLESS_VERSION} && \
    curl -O https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install awscli

# install dev tools
# libsecret-1-dev needed by keytar for azure
# Create ~/.aws folder
RUN apk add tree && \
    apk add nano && \
    apk add libsecret-dev

#Expose Port for Build Info API
EXPOSE ${API_PORT}

WORKDIR /home/srvrlss
CMD ["sls", "--help"]
