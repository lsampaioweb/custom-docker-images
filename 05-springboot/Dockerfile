# Base image.
FROM lsampaioweb/alpine-openjdk:jre-21-1.0

# Proxy Settings.
ENV http_proxy="" \
    https_proxy=""

# Switch to the non-root user.
USER ${APP_USER_NAME}

# Change the working directory.
WORKDIR ${APP_HOME}

# Command to run.
CMD ["sh"]
