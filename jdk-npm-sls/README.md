### README

1. Build the docker image:

```
docker build --label "version=1.0" --label "maintaner=Jose Orsini <orsini.jose@gmail.com.com>" -t serverless:1.32 .
```

2. Run the docker image:

```
docker run -it -p 3000:3000 --name your-container-name-goes-here -v ~/path/to/myNPMProject:/home/srvrlss serverless:1.32 /bin/bash
```

3. Other useful commands:

- Open bash of Docker container (From Host Machine):

```
docker exec -it your-container-name-goes-here bash
```

- Start/stop your container

```
docker container start your-container-name-goes-here
docker container stop your-container-name-goes-here
```