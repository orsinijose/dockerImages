## DOTCMS UNDER DOCKER 

Base dockerfiles taken from 
- https://github.com/jorith88/dotcms-dockerfiles
- https://github.com/AutoScout24/dotcms-docker

dotCMS will start with a H2 Database

For starting dotCMS, run this command.

```
docker build -t dotcms --build-arg DOTCMS_VERSION=3.7.2 . 
docker run -p 8080:8080 -p 8000:8000 dotcms
```

For changing the current dotCMS version, change the `DOTCMS_VERSION` to any valid one you would like to use.

For executing bash within the container, run:

```
docker exec -it {containerIdGoesHere} /bin/bash
```

Going to http://localhost:8080 on a browser should display the frontend of this site.

NOTES:
- It currently supports any existing dotCMS distro.
- It's recommended to specify the dotCMS version name for the image you're creating.

```
docker build -t dotcms_4.2.2 --build-arg DOTCMS_VERSION=4.2.2 . 
docker run -p 8080:8080 -p 8000:8000 dotcms_4.2.2
``` 