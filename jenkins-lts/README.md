### Jenkins LTS + Plugins:

Make sure your plugins.txt file includes the list of plugins required on all environments (interfaces and controllers) located [here](https://github.com/magento-commerce/testing-service-agent-images/tree/master/controller-docker-images/ec2/jenkins-config). For those plugins that are required manually, we'll skip those.

Then, run

```
docker build -t jenkins-lts:2.346.3 .
docker run --rm --name myjenkins -p 8080:8080 -p 50000:50000 -v $(pwd):/var/jenkins_home jenkins-lts:2.346.3
```

After configuring Jenkins for the first time, it will be restarted and then it's ready to use.