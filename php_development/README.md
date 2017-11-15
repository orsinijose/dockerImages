## USING PHP AND APACHE IN DOCKER

- Place the Dockerfile in the root folder of your PHP/HTML project.
- Update the COPY folder if necessary.
- Run 

`docker build -t your-apache-php-image .`

- For running the docker image as a container, run:

`docker run -p 80:80 your-apache-php-image`

Make sure that the port 80 is not used on your Host Machine, otherwise update the used port on your host.