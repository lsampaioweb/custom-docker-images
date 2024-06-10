# Base image.
FROM lsampaioweb/custom-ca:3.20.0-alpine

# Set metadata.
LABEL authors="Luciano Sampaio"

# Which Java (JDK or JRE) to install.
ARG JAVA_PACKAGE="openjdk21-jre-headless"

# Install OpenJDK.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${JAVA_PACKAGE}

# Verify installation.
RUN java --version

# Clean up.
RUN rm -rf /var/cache/apk/*

# Set the environment variable.
ENV JAVA_HOME="/usr/lib/jvm/default-jvm"

# User and Group for the application.
ENV GID=1000
ENV APP_GROUP_NAME="app"

ENV UID=1000
ENV APP_USER_NAME="app"

ENV HOME="/home/${APP_USER_NAME}"

# Create the group.
RUN addgroup -g ${GID} ${APP_GROUP_NAME}

# Create the user.
RUN adduser --disabled-password -h ${HOME} -u ${UID} -G ${APP_GROUP_NAME} -s /bin/sh ${APP_USER_NAME}

# Command to run.
CMD ["sh"]
