### README

1. Build the docker image:

```
docker build -t sonarqube-local:1.0.0 .
```

2. Run the docker image:

```
docker run -d -p 9000:9000 --name sonarqube-local sonarqube-local:1.0.0
```

3. Other useful commands:

- Open bash of Docker container (From Host Machine):

```
docker exec -it sonarqube-local bash
```

- Start/stop your container

```
docker container start sonarqube-local
docker container stop sonarqube-local
```

- Update sonar.properties file:
    - Modify the sonar.properties file inside this folder.
    - Run `docker cp sonar.properties $SONARQUBE_HOME/conf/
    - Login to your Sonarqube server. Under administration panel, restart your Sonarqube server
    - Or: Stop and Start your container.