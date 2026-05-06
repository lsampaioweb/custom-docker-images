# Parent image tag passed from build script.
ARG PARENT_IMAGE_FULLNAME="undefined"

# https://hub.docker.com/_/alpine/
FROM ${PARENT_IMAGE_FULLNAME}

# Argument for the image tag, passed from build script for metadata purposes.
ARG IMAGE_TAG="undefined"

# Set metadata for the image using OCI standard labels.
LABEL org.opencontainers.image.vendor="lsampaioweb" \
      org.opencontainers.image.authors="lsampaioweb <https://github.com/lsampaioweb>" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.title="Java Base Image" \
      org.opencontainers.image.description="Base image for Java applications with locale, SSL certificates, and non-root user." \
      org.opencontainers.image.version="${IMAGE_TAG}"

# Arguments for CA certificates.
ARG CA_CERTIFICATES_PATH="/usr/local/share/ca-certificates/"

# Arguments for locale and time zone settings.
ARG LANG="pt_BR.UTF-8" \
    LANGUAGE="pt_BR:pt" \
    LC_ALL="pt_BR.UTF-8" \
    TZ="America/Maceio"

ENV TZ=$TZ \
    LANG=$LANG \
    LANGUAGE=$LANGUAGE \
    LC_ALL=$LC_ALL

# Use build arguments for proxy settings.
ARG HTTP_PROXY=""
ARG HTTPS_PROXY=""

# Update the OS, install required packages, and set up locale and time zone, including full ICU data.
RUN env http_proxy=$HTTP_PROXY https_proxy=$HTTPS_PROXY && \
    apk update && \
    apk upgrade -a && \
    apk add --no-cache \
      # Install the ca-certificates package to ensure SSL certificates are available.
      ca-certificates \
      # Install these packages ensures that the specified locale is available and works properly when setting LANG, LC_ALL, and other related variables.
      musl-locales \
      musl-locales-lang \
      # Install tzdata package, which includes the time zone data.
      tzdata \
      # Install full ICU data for complete locale support, aligning with configured locales.
      icu-data-full && \
    # Set up the time zone.
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    rm -rf /var/cache/apk/*

# Ensure the locale settings are applied for interactive login shells (e.g., podman exec -it container sh -l).
# The ENV block above already covers all container processes in production.
# If no developer will ever exec into the container interactively, these lines can be removed.
RUN echo "export LANG=${LANG}" >> /etc/profile && \
    echo "export LANGUAGE=${LANGUAGE}" >> /etc/profile && \
    echo "export LC_ALL=${LC_ALL}" >> /etc/profile

# Copy the CA Certificate to the correct folder.
COPY files/ssl/*.crt ${CA_CERTIFICATES_PATH}

# Make the OS trust our CA certificate.
RUN update-ca-certificates

# User and Group for the application.
# APP_UID/APP_GID use the APP_ prefix to avoid conflict with bash's read-only $UID built-in.
ENV APP_GID=1654 \
    APP_UID=1654 \
    APP_GROUP_NAME="app" \
    APP_USER_NAME="app"

# Define the base directory for the application.
ARG APP_BASE_PATH="/opt"

# Define the application's home directory by concatenating the base path and user name.
ENV APP_HOME="${APP_BASE_PATH}/${APP_USER_NAME}"

# Keep HOME aligned with APP_HOME so interactive shells and tools use /opt/app.
ENV HOME="${APP_HOME}"

# Create the group, create the user, and set up the home directory in a single layer.
# --disabled-password: Disable login for the user, ensuring it is a system user.
# -u: Assigns the specified user ID (APP_UID) to the user.
# -h: Sets the home directory for the user to APP_HOME.
# -G: Adds the user to the specified group.
# mkdir -p: Creates the home directory, including any missing parent directories.
# chown -R: Recursively assigns ownership to the application user.
RUN addgroup -g ${APP_GID} ${APP_GROUP_NAME} && \
    adduser --disabled-password -u ${APP_UID} -h ${APP_HOME} -G ${APP_GROUP_NAME} ${APP_USER_NAME} && \
    mkdir -p ${APP_HOME} && \
    chown -R ${APP_USER_NAME}:${APP_GROUP_NAME} ${APP_HOME}

# Command to run.
CMD ["sh"]
