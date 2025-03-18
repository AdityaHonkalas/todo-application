# Stage-1: Build the project with maven
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY . /app

RUN mvn clean package -DskipTests

# Stage-2: Run the above build project with openjdk-17
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8081

CMD ["java", "-jar", "app.jar"]