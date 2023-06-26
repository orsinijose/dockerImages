FROM jenkins/jenkins:2.346.3-2-lts
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
