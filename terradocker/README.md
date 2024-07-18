### README

Docker image running Terraform and Terragrunt, based on [cytopia/docker-terragrunt](https://github.com/cytopia/docker-terragrunt) repo.

1. Build the docker image:

If `TF_VERSION` and `TG_VERSION` args are not passed in, this will default to `latest` versions of Terraform and Terragrunt.

```
docker build --build-arg TF_VERSION=1.6.6 --build-arg TG_VERSION=v0.59.3 --tag terradocker .
```

2. Run the docker image:

```
#!/usr/bin/env bash
docker run -ti --name terradocker -v /Users/josemanuelorsini/Github:/data terradocker
```

3. Add Github and AWS Credentials to your Docker Container.

4. Go to any path and run terragrunt commands.

5. Other useful tips:

- Make sure that the Root folder of your Terraform inventory is mounted. This way, lookups of parent folders can work as expected.
- Since the docker container is not removed after exiting it, it can persist the SSH Keys added for Github, though AWS Credentials may expire. It's advised to stop it

```
docker container stop terradocker
```

- To start the docker container and log in, run 

```
docker container start terradocker
docker exec -ti terradocker /bin/bash
```
