# Base image.
FROM lsampaioweb/openjdk:21-jre

# Set metadata.
LABEL authors="Luciano Sampaio"

# Switch to the non-root user.
USER ${APP_USER_NAME}

# Change the working directory.
WORKDIR ${HOME}

# Command to run.
CMD ["sh"]
