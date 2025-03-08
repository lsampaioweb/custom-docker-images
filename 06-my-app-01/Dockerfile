# Build the image.
FROM lsampaioweb/alpine-springboot:jre-21-1.0 AS image
# FROM lsampaioweb/amazoncorretto:23-headless AS image
# FROM lsampaioweb/eclipse-temurin:23-jre-alpine AS image

# Copy the *.jar file from maven to the image.
COPY ./target/*.jar app.jar

# Command to run the Spring Boot application.
ENTRYPOINT ["java", "-jar", "app.jar"]
