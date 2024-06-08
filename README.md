# custom-docker-images
My own custom docker images.

```bash
docker build -t alpine-with-ca:1.0 --build-arg CA_CERTIFICATE="$(cat ca.crt)" .
docker build -t alpine-with-ca:latest --build-arg CA_CERTIFICATE="$(cat ca.crt)" .

docker run -it --name alpine-with-ca alpine-with-ca:latest
docker exec -it alpine-with-ca:latest sh

wget https://edge-firewall-01.homelab/login
```

```bash
docker build -t alpine-with-openjdk:jdk-1.0 --build-arg JAVA_PACKAGE="openjdk21-jdk" .
docker build -t alpine-with-openjdk:jre-1.0 --build-arg JAVA_PACKAGE="openjdk21-jre-headless" .
docker build -t alpine-with-openjdk:latest .

docker run -it --name alpine-with-openjdk alpine-with-openjdk:latest
docker exec -it alpine-with-openjdk:latest sh

wget https://edge-firewall-01.homelab/login
```
