# Stage 1: Build the JAR file
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

# Copy all files & build
COPY . .
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the jar using JDK runtime
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy built jar
COPY --from=builder /app/target/*.jar app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
