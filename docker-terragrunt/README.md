### README

Docker image running Terraform and Terragrunt, based on [cytopia/docker-terragrunt](https://github.com/cytopia/docker-terragrunt) repo.

1. Build the docker image:

If `TF_VERSION` and `TG_VERSION` args are not passed in, this will default to `latest` versions of Terraform and Terragrunt.

```
docker build --build-arg TF_VERSION=1.3.7 --build-arg TG_VERSION=0.43 --tag terra:latest .
```

2. Run the docker image:

```
#!/usr/bin/env bash
docker run -ti -v /Users/josemanuelorsini/Github:/data terra:latest
```

3. Add Github and AWS Credentials to your Docker Container.

4. Go to any path and run terragrunt commands.

5. Other useful tips:

- Make sure that the Root folder of your Terraform inventory is mounted. This way, lookups of parent folders can work as expected.
