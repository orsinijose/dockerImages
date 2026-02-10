### README

1. Build the docker image:

```
docker build --label "version=1.0" --label "maintaner=Firstname Lastname <your@email.com>" -t node_npm:latest .
```

2. Run the docker image:

```
docker run -ti -p 3000:3000 --name node_npm -v /LocalPathToNPMProjects:/data node_npm:latest
```

3. Other useful commands:

- Open bash of Docker container (From Host Machine):

```
docker exec -it your-container-name-goes-here /bin/bash
```

- Start/stop your container

```
docker container start your-container-name-goes-here
docker container stop your-container-name-goes-here
```
