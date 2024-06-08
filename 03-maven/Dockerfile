# Base image.
FROM lsampaioweb/openjdk:21-jdk

LABEL authors="Luciano Sampaio"

# Which Maven version to install.
ARG MAVEN_APK_VERSION="maven=3.9.6-r0"

# Set environment variables
ENV MAVEN_CONFIG="/root/.m2"

# Install Maven.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${MAVEN_APK_VERSION}

# Clean up.
RUN rm -rf /var/cache/apk/*

# Add a volume pointing to Maven's local repository.
VOLUME ["${MAVEN_CONFIG}"]

# Default command to display Maven version.
CMD ["mvn", "-v"]
