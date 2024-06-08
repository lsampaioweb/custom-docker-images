# Base image.
FROM lsampaioweb/openjdk:21-jdk

LABEL authors="Luciano Sampaio"

# Which Maven version to install.
ARG MAVEN_APK_VERSION="maven=3.9.6-r0"

# Set environment variables
ENV MAVEN_CONFIG_PATH="${APP_FOLDER}/.m2"

# The path where the application's source code of the will be copied to.
ENV MAVEN_BUILD_PATH="${APP_FOLDER}/mvn"

# Install Maven.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${MAVEN_APK_VERSION}

# Clean up.
RUN rm -rf /var/cache/apk/*

# Add a volume pointing to Maven's local repository.
VOLUME ["${MAVEN_CONFIG_PATH}"]

# Create the Maven folders.
RUN mkdir -p ${MAVEN_CONFIG_PATH}
RUN mkdir -p ${MAVEN_BUILD_PATH}

# Set permissions.
RUN chown -R ${APP_USER_NAME}:${APP_GROUP_NAME} ${APP_FOLDER}

# Set the working directory.
WORKDIR ${MAVEN_BUILD_PATH}

# Switch to the non-root user.
USER ${APP_USER_NAME}

# Command to run.
CMD ["sh"]
