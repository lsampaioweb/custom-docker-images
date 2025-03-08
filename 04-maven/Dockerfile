# Base image.
FROM lsampaioweb/alpine-openjdk:jdk-21-1.0

# Which Maven version to install.
ARG MAVEN_APK_VERSION=""
# ARG MAVEN_GLOBAL_CONFIG="/usr/share/java/maven-3/conf/"

# Directory for Maven dependency cache.
# This directory stores Maven artifacts to improve build performance.
ENV MAVEN_CACHE_DIR="/root/.m2"

# Install Maven.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${MAVEN_APK_VERSION}

# Verify installation.
RUN mvn --version

# Copy the settings file into the image.
# COPY config/settings.xml ${MAVEN_GLOBAL_CONFIG}

# Clean up.
RUN rm -rf "/var/cache/apk/*"

# Command to run.
CMD ["sh"]
