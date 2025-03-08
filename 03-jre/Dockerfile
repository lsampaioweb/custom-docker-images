# Base image.
FROM lsampaioweb/alpine-base:3.21-1.0

# Specify the Java package to install (default is empty, allowing flexibility).
ARG JAVA_PACKAGE=""

# Update the OS and install the specified Java package.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${JAVA_PACKAGE}

# Verify installation.
RUN java --version

# Clean up.
RUN rm -rf "/var/cache/apk/*"

# Set the environment variable.
ENV JAVA_HOME="/usr/lib/jvm/default-jvm"

# Command to run.
CMD ["sh"]
