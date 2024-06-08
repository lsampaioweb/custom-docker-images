# Base image.
FROM lsampaioweb/custom-ca:3.20.0-alpine

LABEL authors="Luciano Sampaio"

# Which Java (JDK or JRE) to install.
ARG JAVA_PACKAGE="openjdk21-jre-headless"

# Install OpenJDK.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${JAVA_PACKAGE}

# Verify installation.
RUN java -version

# Set the environment variable.
ENV JAVA_HOME="/usr/lib/jvm/default-jvm"

# User and Group for the application.
ENV APP_USER_NAME="app"
ENV APP_GROUP_NAME="app"
ENV APP_FOLDER="/app"

# Create the group.
RUN addgroup --system ${APP_GROUP_NAME}

# Create the user.
RUN adduser --system ${APP_USER_NAME} -G ${APP_GROUP_NAME}

# Create application directory.
RUN mkdir -p ${APP_FOLDER}

# Set permissions.
RUN chown -R ${APP_USER_NAME}:${APP_GROUP_NAME} ${APP_FOLDER}

# Clean up.
RUN rm -rf /var/cache/apk/*

# Command to run.
CMD ["sh"]
