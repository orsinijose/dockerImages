FROM anapsix/alpine-java:8_jdk

ENV DOTCMS_HOME /opt/dotcms/wwwroot/current

ENV TOMCAT_VERSION 8.0.18

ARG DOTCMS_VERSION
ENV DOTCMS_DISTRO=$DOTCMS_VERSION

RUN apk add --update bash curl && rm -rf /var/cache/apk/* \
    && mkdir -p $DOTCMS_HOME \
    && curl -O https://dotcms.com/physical_downloads/release_builds/dotcms_$DOTCMS_DISTRO.tar.gz \
    && tar xzf dotcms_$DOTCMS_DISTRO.tar.gz -C $DOTCMS_HOME \
    && rm dotcms_$DOTCMS_DISTRO.tar.gz \
    && chmod +x $DOTCMS_HOME/bin/*.sh \
    && chmod +x $DOTCMS_HOME/dotserver/tomcat-$TOMCAT_VERSION/bin/*.sh

ADD context.xml $DOTCMS_HOME/dotserver/tomcat-8.0.18/webapps/ROOT/META-INF/context.xml

EXPOSE 8080 8009 8000

CMD ["sh", "-c", "${DOTCMS_HOME}/bin/startup.sh run"]