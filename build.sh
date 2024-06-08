cd 01-custom-ca/
docker build -t lsampaioweb/custom-ca:3.20.0-alpine --build-arg CA_CERTIFICATE="$(cat ca.crt)" .
# docker build -t lsampaioweb/custom-ca:latest --build-arg CA_CERTIFICATE="$(cat ca.crt)" .
cd ..

cd 02-openjdk/
docker build -t lsampaioweb/openjdk:21-jdk --build-arg JAVA_PACKAGE="openjdk21-jdk" .
docker build -t lsampaioweb/openjdk:21-jre --build-arg JAVA_PACKAGE="openjdk21-jre-headless" .
# docker build -t lsampaioweb/openjdk:latest .
cd ..

cd 03-maven/
docker build -t lsampaioweb/maven:3.9.6 --build-arg MAVEN_APK_VERSION="maven=3.9.6-r0" .
# docker build -t lsampaioweb/maven:latest .
cd ..

cd 04-springboot/
docker build -t lsampaioweb/springboot:1.0 .
cd ..

# # docker push lsampaioweb/custom-ca:3.20.0-alpine
# # docker push lsampaioweb/custom-ca:latest

# # docker push lsampaioweb/openjdk:21-jdk
# # docker push lsampaioweb/openjdk:21-jre
# # docker push lsampaioweb/openjdk:latest

# # docker push lsampaioweb/maven:3.9.6
# # docker push lsampaioweb/maven:latest
