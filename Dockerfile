FROM alpine as build_lumisportal
ENV LUMIS_VERSION 12.2.0.200122
ENV TOMCAT_VERSION 9
ENV TOMCAT_RELEASE 9.0.30 
WORKDIR /usr/local/lumisportal
RUN apk -Uuv add zip curl 
RUN curl https://lumisportal-repo.s3.amazonaws.com/lumisportal_${LUMIS_VERSION}.zip --output lumisportal_${LUMIS_VERSION}.zip 
RUN unzip lumisportal_${LUMIS_VERSION}.zip 
RUN rm -f lumisportal_${LUMIS_VERSION}.zip
RUN rm -fr lptf opt .LumisPortalFiles development .classpath .project readme.txt
    
FROM alpine as build_tomcat
ENV TOMCAT_VERSION 9
ENV TOMCAT_RELEASE 9.0.30 
RUN apk -Uuv add curl 
RUN mkdir -p /usr/local/tomcat
RUN curl https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION}/v${TOMCAT_RELEASE}/bin/apache-tomcat-${TOMCAT_RELEASE}.tar.gz --output apache-tomcat-${TOMCAT_RELEASE}.tar.gz
RUN tar -zxf apache-tomcat-${TOMCAT_RELEASE}.tar.gz
RUN mv apache-tomcat-${TOMCAT_RELEASE}/* /usr/local/tomcat 
RUN rm -fr apache-tomcat-*

FROM amazonlinux:2.0.20200207.1
LABEL maintainer="jeduoliveira81@gmail.com"
LABEL version="1.0"

ENV TZ "America/Sao_Paulo"
ENV ES_HOME /usr/share/elasticsearch

ENV LUMIS_HOME /usr/local/lumisportal
ENV LUMIS_HOME_WWW ${LUMIS_HOME}/www
ENV LUMIS_HTDOCS /usr/local/htdocs
ENV LUMIS_DB_MINIMUM_IDLE=25
ENV LUMIS_DB_MAXIMUM_POOL_SIZE=60

ENV TOMCAT_AJP_MAX_THREADS 25
ENV TOMCAT_HTTP_MAX_THREADS 5
ENV TOMCAT_HEAP 512m
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH ${CATALINA_HOME}/bin:${PATH}
ENV TOMCAT_NATIVE_LIBDIR ${CATALINA_HOME}/native-jni-lib
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}${TOMCAT_NATIVE_LIBDIR}

RUN yum -y install mysql java-1.9.0-openjdk

COPY --from=build_lumisportal /usr/local/lumisportal/ /usr/local/lumisportal
COPY ./12.2.0.200122/ .

WORKDIR ${CATALINA_HOME}
COPY --from=build_tomcat /usr/local/tomcat /usr/local/tomcat
COPY ./tomcat/ .
COPY ./elasticsearch/config/lumis-analysis ${ES_HOME}/config/lumis-analysis 
RUN set -x \
    && groupadd elasticsearch \
    && useradd -s /bin/nologin -g elasticsearch -d ${ES_HOME} elasticsearch \
    && mkdir -p ${LUMIS_HOME}/lumisdata/shared/data/elasticsearch \
    && ln -s ${ES_HOME}/config/lumis-analysis ${LUMIS_HOME}/lumisdata/shared/data/elasticsearch/lumis-analysis \
    && chown -R elasticsearch:root $ES_HOME \
    && chmod +x ${CATALINA_HOME}/bin/*.sh \
    && mkdir -p ${LUMIS_HTDOCS} \
    && cp -r ${LUMIS_HOME}/www/lumis* ${LUMIS_HTDOCS} \
    && find . -name "*.jsp" -exec rm -rf {} \; \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && chown -R elasticsearch:root ${ES_HOME}/config/lumis-analysis \
    && chmod -R 755 ${ES_HOME}/config/lumis-analysis 

VOLUME ${LUMIS_HOME}/lumisdata/data
VOLUME ${LUMIS_HOME}/lumisdata/shared
VOLUME ${ES_HOME}/config/lumis-analysis
VOLUME ${LUMIS_HTDOCS}

COPY docker-entrypoint.sh /
COPY wait-for-mysql.sh /
COPY initialize-lumis.sh /
COPY config.sql /

EXPOSE 8080
EXPOSE 8009

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bin/catalina.sh", "run"]