### README

Docker image running Terraform and Terragrunt, based on [cytopia/docker-terragrunt](https://github.com/cytopia/docker-terragrunt) repo.

1. Build the docker image:

If `TF_VERSION` and `TG_VERSION` args are not passed in, this will default to `latest` versions of Terraform and Terragrunt.

```bash
docker build --platform linux/x86_64 --build-arg TF_VERSION=1.12.2 --build-arg TG_VERSION=v0.99.1 --build-arg NODE_VERSION=22 --tag terradocker:latest .
```

2. Run the docker image:

```bash
#!/usr/bin/env bash
docker run -ti --platform linux/x86_64 --name terradocker -v /PathToYourLocal:/home/terradocker terradocker
```

3. Add [Github SSH Keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) and AWS Credentials to your Docker Container.

4. Go to any path and run terragrunt commands.

5. Other useful tips:

- Make sure that the Root folder of your Terraform inventory is mounted. This way, lookups of parent folders can work as expected.
- Since the docker container is not removed after exiting it, it can persist the SSH Keys added for Github, though AWS Credentials may expire.
- To run:

```
docker container stop terradocker
```

- To start the docker container and log in, run:

```
docker container start terradocker
docker exec -ti terradocker /bin/bash
```
