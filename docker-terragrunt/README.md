### README

Docker image running Terraform and Terragrunt, based on [cytopia/docker-terragrunt](https://github.com/cytopia/docker-terragrunt) repo.

1. Build the docker image:

If `TF_VERSION` and `TG_VERSION` args are not passed in, this will default to `latest` versions of Terraform and Terragrunt.

```
docker build --build-arg TF_VERSION=0.11 --build-arg TG_VERSION=0.18 --tag tf-tg:0.11-0.18 .
docker build --build-arg TF_VERSION=0.12 --build-arg TG_VERSION=0.19 --tag tf-tg:0.12-0.19 .
```

2. Run the docker image:

```
#!/usr/bin/env bash
# Run terragrunt plan before applying changes
docker run --rm \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
  -v /root-path/to/terraform/project/:/data \
  -v /path/to/.ssh:/root/.ssh \
  -v /path/to/.aws:/root/.aws \
  -w /data/path-to-tf-or-hcl-file-to-evaluate \
your-image-name:your-tag terragrunt plan

# Non Interactive Apply defaults to yes. Proceed with caution here
docker run --rm \
  -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
  -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
  -v /root-path/to/terraform/project/:/data \
  -v /path/to/.ssh:/root/.ssh \
  -v /path/to/.aws:/root/.aws \
  -w /data/path-to-tf-or-hcl-file-to-evaluate \
your-image-name:your-tag terragrunt --terragrunt-non-interactive apply
```

3. Other useful tips:

- Make sure that the Root folder of your Terraform inventory is mounted. This way, lookups of parent folders can work as expected.

- If there's an error with ssh upon running `docker run`:

```
Bad configuration option: usekeychain
```

Follow these steps.

- Make a backup of your `~/.ssh/config` file.
- Open the  `~/.ssh/config` file.
- Remove the occurrences of `UseKeychain yes` in this file. Save.
- Re-run the `docker run` command.