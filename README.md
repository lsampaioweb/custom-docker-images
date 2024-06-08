# custom-docker-images
My own custom docker images.

```bash
docker build -t lsampaioweb/custom-ca:3.20.0-alpine --build-arg CA_CERTIFICATE="$(cat ca.crt)" .
docker build -t lsampaioweb/custom-ca:latest --build-arg CA_CERTIFICATE="$(cat ca.crt)" .

docker run -it --name lsampaioweb/custom-ca lsampaioweb/custom-ca:latest
docker exec -it lsampaioweb/custom-ca:latest sh

wget https://edge-firewall-01.homelab/login
```

```bash
docker build -t lsampaioweb/openjdk:21-jdk --build-arg JAVA_PACKAGE="openjdk21-jdk" .
docker build -t lsampaioweb/openjdk:21-jre --build-arg JAVA_PACKAGE="openjdk21-jre-headless" .
docker build -t lsampaioweb/openjdk:latest .

docker run -it --name openjdk lsampaioweb/openjdk:jdk-1.0
docker exec -it lsampaioweb/openjdk:latest sh
```

```bash
apk search -v maven
docker build -t lsampaioweb/maven:3.9.6 .
docker build -t lsampaioweb/maven:3.9.6 --build-arg MAVEN_APK_VERSION="maven=3.9.6-r0" .
docker build -t lsampaioweb/maven:latest .
```

```bash
wget https://github.com/docker/docker-credential-helpers/releases/download/v0.8.2/docker-credential-secretservice-v0.8.2.linux-amd64
mv docker-credential-secretservice-v0.8.2.linux-amd64 docker-credential-secretservice
sudo mv docker-credential-secretservice /usr/local/bin/
sudo chmod +x /usr/local/bin/docker-credential-secretservice

nano ~/.docker/config.json
{
  "credsStore": "secretservice"
}

docker login -u lsampaioweb

docker push lsampaioweb/custom-ca:1.0
docker push lsampaioweb/openjdk:jre-1.0
docker push lsampaioweb/openjdk:jdk-1.0

```
