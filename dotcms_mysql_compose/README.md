## DOTCMS UNDER DOCKER 

Base dockerfiles taken from 
- https://github.com/jorith88/dotcms-dockerfiles
- https://github.com/AutoScout24/dotcms-docker

dotCMS will start with a MySQL Database, created on a separate container.

For starting dotCMS, run this command.

```
docker-compose up -d
```

For accessing the bash of dotCMS instance, run

```
docker exec -it {containerIdGoesHere} /bin/bash
```

Going to http://localhost:8080 on a browser should display the frontend of this site.

NOTES:
- It currently supports dotCMS 4.2.0. 
- docker-compose.yml file can be edited and DOTCMS_VERSION can point to any existing version of dotCMS.
- MySQL Passwords and access are configured on docker-compose.yml file.
- A com.dotcms.config plugin is in place here for Docker to deploy it once the image is built
- Same approach for customizing the context.xml file can be applied to other files and scripts, such as bin/startup.sh. Just place your custom files inside the com.dotcms.plugin file and use a similar call to this one 


TO-DO: 
- Import a SQL dump and place proper scripting.
- Secure assets, dotsecure and felix folders under persistent storage.
- Secure mysql-data under persistent storage