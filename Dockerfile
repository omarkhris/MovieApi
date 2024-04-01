# Use the official Maven/Java 8 image as a build stage
FROM maven:3.8.4-openjdk-8 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project file
COPY pom.xml .

# Copy the project source code
COPY src src/

# Build the application
RUN mvn clean package -DskipTests

# Use AdoptOpenJDK 8 as the base image for the runtime environment
FROM adoptopenjdk:8-jre-hotspot

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage to the runtime image
COPY --from=build /app/target/App-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the application runs on
EXPOSE 8080

# Specify the command to run the application
CMD ["java", "-jar", "app.jar"]
