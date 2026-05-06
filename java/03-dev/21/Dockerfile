# Parent image tag passed from build script.
ARG PARENT_IMAGE_FULLNAME="undefined"

# Base image.
FROM ${PARENT_IMAGE_FULLNAME}

# Argument for the image tag, passed from build script for metadata purposes.
ARG IMAGE_TAG="undefined"

# Set metadata for the image using OCI standard labels.
LABEL org.opencontainers.image.vendor="lsampaioweb" \
      org.opencontainers.image.authors="lsampaioweb <https://github.com/lsampaioweb>" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="Java Development Environment" \
      org.opencontainers.image.description="Complete development environment with JDK for building and developing applications." \
      org.opencontainers.image.version="${IMAGE_TAG}"

# Specify the Java package to install (default is empty, allowing flexibility).
ARG PACKAGE=""

# Use build arguments for proxy settings.
ARG HTTP_PROXY=""
ARG HTTPS_PROXY=""

# Update the OS and install required packages.
RUN env http_proxy=$HTTP_PROXY https_proxy=$HTTPS_PROXY && \
    apk update && \
    apk upgrade -a && \
    apk add --no-cache ${PACKAGE} && \
    rm -rf /var/cache/apk/*

# Set the environment variable.
ENV JAVA_HOME="/usr/lib/jvm/default-jvm"

# Verify installation.
RUN java --version

# Command to run.
CMD ["sh"]
