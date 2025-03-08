# Base image.
FROM alpine:3.21

# Set metadata.
LABEL authors="Luciano Sampaio"

# Proxy Settings.
# ENV http_proxy="http://host.docker.internal:3128" \
#     https_proxy="http://host.docker.internal:3128"

# Arguments for CA certificates.
ARG CA_CERTIFICATES_PATH="/usr/local/share/ca-certificates/"

# Set environment variables for locale and time zone.
ENV TZ="America/Maceio" \
    LANG="pt_BR.UTF-8" \
    LANGUAGE="pt_BR:pt" \
    LC_ALL="pt_BR.UTF-8"

# Update the OS, install required packages, and set up locale and time zone.
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
      # Install the ca-certificates package to ensure SSL certificates are available.
      ca-certificates \
      # Install these packages ensures that the specified locale is available and works properly when setting LANG, LC_ALL, and other related variables.
      musl-locales \
      musl-locales-lang \
      # Install tzdata package, which includes the time zone data.
      tzdata && \
    # Set up the time zone.
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone

# Ensure the locale settings are applied.
RUN echo "export LANG=${LANG}" >> /etc/profile && \
    echo "export LANGUAGE=${LANGUAGE}" >> /etc/profile && \
    echo "export LC_ALL=${LC_ALL}" >> /etc/profile

# Copy the CA Certificate to the correct folder.
COPY ssl/*.crt ${CA_CERTIFICATES_PATH}

# Make the OS trust our CA certificate.
RUN update-ca-certificates

# User and Group for the application.
ENV GID=1112 \
    UID=1112 \
    APP_GROUP_NAME="app" \
    APP_USER_NAME="app"

# Create the group.
RUN addgroup -g ${GID} ${APP_GROUP_NAME}

# Create the user with the specified parameters:
# --no-create-home: Avoid creating a home directory for the user, as it's not needed.
# --disabled-password: Disable login for the user, ensuring it's a system user.
# -u: Assigns the specified user ID (UID) to the user.
# -G: Adds the user to the specified group.
# RUN adduser --no-create-home --disabled-password -u ${UID} -G ${APP_GROUP_NAME} ${APP_USER_NAME}
RUN adduser --disabled-password -u ${UID} -G ${APP_GROUP_NAME} ${APP_USER_NAME}

# Define the base directory for the application.
ARG USER_BASE_PATH="/home"

# Define the base directory for the application.
ARG APP_BASE_PATH="/opt"

# Define the home directory for the application user.
# This is where the user's personal files and configurations (e.g., .m2 for Maven) will be stored.
ENV HOME="${USER_BASE_PATH}/${APP_USER_NAME}"

# Define the application's home directory by concatenating the base path and user name.
ENV APP_HOME="${APP_BASE_PATH}/${APP_USER_NAME}"

# Create the application's home directory.
# -p ensures parent directories are created if they don't exist.
RUN mkdir -p ${APP_HOME}

# Change ownership of the application's home directory.
# -R: Recursively applies ownership to all files and subdirectories.
# Assign ownership to the application user for security and proper file access control.
RUN chown -R ${APP_USER_NAME}:${APP_GROUP_NAME} ${APP_HOME}

# Clean up package manager caches to reduce image size.
RUN rm -rf "/var/cache/apk/*"

# Command to run.
CMD ["sh"]
