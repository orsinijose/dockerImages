### Jenkins LTS + Plugins

Keep `plugins.txt` in sync with the list required for your environments (interfaces and controllers). Reference: [jenkins-config](https://github.com/magento-commerce/testing-service-agent-images/tree/master/controller-docker-images/ec2/jenkins-config). Plugins that must be installed manually via the Jenkins UI are not included here.

---

#### 1. Build the image

```bash
docker build -t myjenkins-blueocean:2.541.2-lts .
```

#### 2a. Run Jenkins only (no Docker-from-Jenkins)

Use this if you do **not** need pipelines to build or run Docker images:

```bash
docker build -t myjenkins-blueocean:2.580.1-lts .
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  myjenkins-blueocean:2.580.1-lts
```

#### 2b. Run Jenkins with Docker (for Docker pipelines)

Use this when pipelines need to run Docker commands (build/run containers). First start a Docker-in-Docker sidecar and network:

```bash
docker network create jenkins
docker run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind \
  --storage-driver overlay2
```

Then run Jenkins connected to that daemon:

```bash
docker build -t myjenkins-blueocean:2.580.1-lts .
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:2.580.1-lts
```

Choose **either** 2a or 2b; the dind setup (2b) is only required for Docker-based pipelines.
