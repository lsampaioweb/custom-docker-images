# Custom Docker Images

This repository contains instructions for building and using custom Docker images for various components of your project. Follow the steps below to set up, build, and push your custom Docker images.

## Prerequisites

- Ensure you have Docker installed on your system.
- Ensure you have wget installed on your system.
- Ensure you have nano installed on your system (or use your preferred text editor).

## Setting Up Docker Credential Helpers

1. Download the Docker Credential Helper:
    ```bash
    wget https://github.com/docker/docker-credential-helpers/releases/download/v0.8.2/docker-credential-secretservice-v0.8.2.linux-amd64
    ```

1. Rename the downloaded file:
    ```bash
    mv docker-credential-secretservice-v0.8.2.linux-amd64 docker-credential-secretservice
    ```

1. Move the file to /usr/local/bin:
    ```bash
    sudo mv docker-credential-secretservice /usr/local/bin/
    ```

1. Make the file executable:
    ```bash
    sudo chmod +x /usr/local/bin/docker-credential-secretservice
    ```

1. Configure Docker to use the credential helper:

    Once you log in, your password will be saved, and you won't have to type it every time you use Docker commands.

    ```bash
    nano ~/.docker/config.json
    ```

    Add the following content:
    ```json
    {
      "credsStore": "secretservice"
    }
    ```

1. Log in to Docker:
    ```bash
    docker login -u <your user>
    ```

## Building Custom Docker Images

1. Custom CA Image

    1. Build the Custom CA image:
        ```bash
        docker build -t lsampaioweb/custom-ca:3.20.0-alpine --build-arg CA_CERTIFICATE="$(cat ca.crt)" .

        docker build -t lsampaioweb/custom-ca:latest --build-arg CA_CERTIFICATE="$(cat ca.crt)" .
        ```

    1. Run and access the Custom CA container:
        ```bash
        docker run -it --name custom-ca lsampaioweb/custom-ca:latest
        docker exec -it custom-ca sh
        ```

    1. Push the image to Docker Hub:

        ```bash
        docker push lsampaioweb/custom-ca:latest
        ```

1. OpenJDK Image

    1. Build the OpenJDK images:
        ```bash
        docker build -t lsampaioweb/openjdk:21-jdk --build-arg JAVA_PACKAGE="openjdk21-jdk" .

        docker build -t lsampaioweb/openjdk:21-jre --build-arg JAVA_PACKAGE="openjdk21-jre-headless" .

        docker build -t lsampaioweb/openjdk:latest .
        ```

    1. Run and access the OpenJDK container:
        ```bash
        docker run -it --name openjdk-jdk lsampaioweb/openjdk:21-jdk
        docker exec -it openjdk-jdk sh

        docker run -it --name openjdk-jre lsampaioweb/openjdk:21-jre
        docker exec -it openjdk-jre sh
        ```

    1. Push the image to Docker Hub:

        ```bash
        docker push lsampaioweb/openjdk:21-jdk
        docker push lsampaioweb/openjdk:21-jre
        ```

1. Maven Image

    1. Search for the Maven package:
        ```bash
        apk search -v maven
        ```

    1. Build the Maven images:
        ```bash
        docker build -t lsampaioweb/maven:3.9.6 .

        docker build -t lsampaioweb/maven:3.9.6 --build-arg MAVEN_APK_VERSION="maven=3.9.6-r0" .

        docker build -t lsampaioweb/maven:latest .
        ```

    1. Run and access the Maven container:
        ```bash
        docker run -it --name maven lsampaioweb/maven:3.9.6
        docker exec -it maven sh
        ```

    1. Push the image to Docker Hub:

        ```bash
        docker push lsampaioweb/maven:3.9.6
        ```

1. Spring Boot Image

    1. Build the Spring Boot images:
        ```bash
        docker build -t lsampaioweb/springboot:1.0 .

        docker build -t lsampaioweb/springboot:latest .
        ```

    1. Run and access the Spring Boot container:
        ```bash
        docker run -it --name springboot lsampaioweb/springboot:1.0
        docker exec -it springboot sh
        ```

    1. Push the image to Docker Hub:

        ```bash
        docker push lsampaioweb/springboot:1.0
        ```

1. Your Spring Boot Application

    1. Build your application images:
        ```bash
        docker build -t lsampaioweb/container:1.0 .

        docker build -t lsampaioweb/container:1.1 --build-arg SERVER_PORT=8081 .
        ```

    1. Run and access the your container:
        ```bash
        docker run -it --name container lsampaioweb/container:1.0
        ```

    1. Push the image to Docker Hub:

        ```bash
        docker push lsampaioweb/container:1.0
        ```
#
### Created by:

1. Luciano Sampaio.
