# Base image.
FROM lsampaioweb/openjdk:21-jre

LABEL authors="Luciano Sampaio"

# The path where Maven stored the compiled application.
ENV MAVEN_TARGET_FOLDER="${APP_FOLDER}/mvn/target"

# Expose the port the application runs on.
EXPOSE 8080

# Change the working directory.
WORKDIR ${APP_FOLDER}

# Switch to the non-root user.
USER ${APP_USER_NAME}

# Command to run.
CMD ["sh"]
