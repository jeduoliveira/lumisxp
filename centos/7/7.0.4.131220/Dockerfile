ARG LUMIS_VERSION=${LUMISVERSION:-7.0.4.131220}

FROM alpine as build_lumisportal
ARG LUMIS_VERSION
ENV LUMIS_VERSION=${LUMIS_VERSION}
WORKDIR /usr/local/lumisportal
RUN set -ex \
    && apk -Uuv add zip curl \
    && curl https://lumisportal-repo.s3.amazonaws.com/lumisportal_${LUMIS_VERSION}.zip --output lumisportal_${LUMIS_VERSION}.zip \
    && unzip lumisportal_${LUMIS_VERSION}.zip \
    && rm -f lumisportal_${LUMIS_VERSION}.zip \ 
    && rm -fr lptf opt .LumisPortalFiles development .classpath .project readme.txt 


ADD ./lumisdata/config ./lumisdata/config
ADD ./lib/ www/WEB-INF/lib/
    
FROM alpine as build_tomcat
ARG LUMIS_VERSION
ENV TOMCAT_VERSION 7
ENV TOMCAT_RELEASE 7.0.109
RUN set -ex \
    && apk -Uuv add curl \
    && mkdir -p /usr/local/tomcat \
    && curl https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION}/v${TOMCAT_RELEASE}/bin/apache-tomcat-${TOMCAT_RELEASE}.tar.gz --output apache-tomcat-${TOMCAT_RELEASE}.tar.gz \
    && tar -zxf apache-tomcat-${TOMCAT_RELEASE}.tar.gz \ 
    && mv apache-tomcat-${TOMCAT_RELEASE}/* /usr/local/tomcat \
    && rm -fr apache-tomcat-*

FROM centos:7
LABEL maintainer="jeduoliveira81@gmail.com"
LABEL version="1.0"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV LUMIS_VERSION=${LUMIS_VERSION}
ENV ES_HOME=/usr/share/elasticsearch
ENV LUMIS_HOME=/usr/local/lumisportal
ENV LUMIS_HOME_WWW=${LUMIS_HOME}/www
ENV LUMIS_HTDOCS=/usr/local/htdocs
ENV LUMIS_DB_MINIMUM_IDLE=25
ENV LUMIS_DB_MAXIMUM_POOL_SIZE=60
ENV TOMCAT_AJP_MAX_THREADS=25
ENV TOMCAT_HTTP_MAX_THREADS=5
ENV TOMCAT_HEAP=512m
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=${CATALINA_HOME}/bin:${PATH}
ENV TOMCAT_NATIVE_LIBDIR=${CATALINA_HOME}/native-jni-lib
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}${TOMCAT_NATIVE_LIBDIR}

RUN set -x 
    
    RUN  yum -q -y install mysql java-1.7.0-openjdk 
    RUN  mkdir -p ${LUMIS_HTDOCS} 
    RUN  yum clean all  
    RUN  rm -rf /var/cache/yum

WORKDIR /usr/local/lumisportal

COPY --from=build_tomcat /usr/local/tomcat /usr/local/tomcat
COPY --from=build_lumisportal /usr/local/lumisportal/ /usr/local/lumisportal

WORKDIR /usr/local/lumisportal/setup
ENV JAVA_HOME=/usr/lib/jvm/jre-1.7.0

ADD setup/generatesql.sh .
RUN chmod +x *.sh \
    && sh generatesql.sh

WORKDIR ${CATALINA_HOME}

ADD ./tomcat/bin/ ./bin 
ADD ./tomcat/conf/ ./conf 

RUN set -x \
    && cp -r ${LUMIS_HOME}/www/lumis* ${LUMIS_HTDOCS} \
    && find ${LUMIS_HTDOCS} -name "*.jsp" -exec rm -rf {} \; \
    && chmod +x ${CATALINA_HOME}/bin/*.sh 

VOLUME ${LUMIS_HOME}/lumisdata/data
VOLUME ${LUMIS_HOME}/lumisdata/shared

VOLUME ${LUMIS_HTDOCS}

COPY docker-entrypoint.sh /
COPY wait-for-mysql.sh /
COPY initialize-lumis.sh /


EXPOSE 8080
EXPOSE 8009

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/catalina.sh", "run"]