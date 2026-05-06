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
      org.opencontainers.image.title="Java Console Application" \
      org.opencontainers.image.description="Production-optimized environment for console and CLI applications." \
      org.opencontainers.image.version="${IMAGE_TAG}"

# Switch to the non-root user.
USER ${APP_USER_NAME}

# Change the working directory.
WORKDIR ${APP_HOME}

# Command to run.
CMD ["sh"]
