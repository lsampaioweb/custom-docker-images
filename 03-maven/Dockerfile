# Base image.
FROM lsampaioweb/openjdk:21-jdk

# Set metadata.
LABEL authors="Luciano Sampaio"

# Which Maven version to install.
ARG MAVEN_APK_VERSION="maven=3.9.6-r0"

# Install Maven.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${MAVEN_APK_VERSION}

# Verify installation.
RUN mvn --version

# Clean up.
RUN rm -rf /var/cache/apk/*

# Switch to the non-root user.
USER ${APP_USER_NAME}

# Set the working directory.
WORKDIR ${HOME}

# Command to run.
CMD ["sh"]
