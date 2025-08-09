## Stage 1: Build the Spring Boot app
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

## Stage 2: Run the app with curl support
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/LibraryManager-0.0.1-SNAPSHOT.war app.war

# Required for Docker healthcheck
RUN apt-get update && apt-get install -y curl

EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.war"]

