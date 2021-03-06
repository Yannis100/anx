FROM tomcat:9-jdk8-adoptopenjdk-openj9
LABEL maintainer "Steven Barth <stbarth@cisco.com>"

RUN apt-get update -qq && apt-get install -yqq maven

COPY anc /src/anc/
COPY explorer /src/explorer/
COPY grpc /src/grpc/
COPY pom.xml /src/

RUN cd /src && mvn package javadoc:javadoc && cp /src/explorer/target/*.war /usr/local/tomcat/webapps/ROOT.war && \
    cp -a /src/anc/target/site/apidocs /usr/local/tomcat/webapps/ && mkdir /usr/local/yangcache && \
    rm -rf /usr/local/tomcat/webapps/ROOT && cd / && rm -r /src /root/.m2 && apt-get clean && apt-get autoclean

EXPOSE 8080
