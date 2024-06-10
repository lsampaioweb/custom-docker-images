#!/bin/bash
set -e # Abort if there is an issue with any build.

# cd 01-custom-ca/
# docker build -t lsampaioweb/custom-ca:3.20.0-alpine --build-arg CA_CERTIFICATE="$(cat ca.crt)" . > ../build/custom-ca.log 2>&1
# cd -

# cd 02-openjdk/
# docker build -t lsampaioweb/openjdk:21-jdk --build-arg JAVA_PACKAGE="openjdk21-jdk" . > ../build/openjdk-21-jdk.log 2>&1
# docker build -t lsampaioweb/openjdk:21-jre --build-arg JAVA_PACKAGE="openjdk21-jre-headless" . > ../build/openjdk-21-jre.log 2>&1
# cd -

# cd 03-maven/
# docker build -t lsampaioweb/maven:3.9.6 --build-arg MAVEN_APK_VERSION="maven=3.9.6-r0" . > ../build/maven.log 2>&1
# cd -

# cd 04-springboot/
# docker build -t lsampaioweb/springboot:1.0 . > ../build/springboot.log 2>&1
# cd -

# cd ../spring-boot/tutorial/samples/06-container/
# docker build -t lsampaioweb/container:1.0 . > target/container.log 2>&1
# # docker build -t lsampaioweb/container:1.0 --build-arg SERVER_PORT=8080 .
# cd -

# docker push lsampaioweb/custom-ca:3.20.0-alpine
docker push lsampaioweb/openjdk:21-jre
docker push lsampaioweb/openjdk:21-jdk
docker push lsampaioweb/maven:3.9.6
docker push lsampaioweb/springboot:1.0
