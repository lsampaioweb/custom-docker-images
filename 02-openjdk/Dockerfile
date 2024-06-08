# Base image.
FROM lsampaioweb/custom-ca:3.20.0-alpine

LABEL authors="Luciano Sampaio"

# Which Java (JDK or JRE) to install.
ARG JAVA_PACKAGE=openjdk21-jre-headless

# Install OpenJDK.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${JAVA_PACKAGE}

# Verify installation.
RUN java -version

# Set the environment variable.
ENV JAVA_HOME=/usr/lib/jvm/default-jvm

# Clean up.
RUN rm -rf /var/cache/apk/*

# Command to run.
CMD ["sh"]
