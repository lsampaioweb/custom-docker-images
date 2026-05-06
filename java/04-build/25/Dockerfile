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
      org.opencontainers.image.title="Java Build Environment" \
      org.opencontainers.image.description="Specialized build environment with Maven for CI/CD pipelines." \
      org.opencontainers.image.version="${IMAGE_TAG}"

# Which Maven version to install.
ARG PACKAGE=""
ARG MAVEN_GLOBAL_CONFIG="/usr/share/java/maven-3/conf/"

# Directory for Maven dependency cache.
ENV MAVEN_CACHE_DIR="/root/.m2"

# Use build arguments for proxy settings.
ARG HTTP_PROXY=""
ARG HTTPS_PROXY=""

# Update the OS and install Maven.
RUN env http_proxy=$HTTP_PROXY https_proxy=$HTTPS_PROXY && \
    apk update && \
    apk upgrade -a && \
    apk add --no-cache ${PACKAGE} && \
    rm -rf /var/cache/apk/*

# Verify installation.
RUN mvn --version

# Copy the settings file into the image.
COPY files/config/settings.xml ${MAVEN_GLOBAL_CONFIG}

# Change the working directory.
WORKDIR ${APP_HOME}

# Command to run.
CMD ["sh"]
