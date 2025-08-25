# Build stage
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY HelloServer.java .
RUN javac HelloServer.java

# Runtime stage
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/HelloServer.class .
ENV PORT=8080
EXPOSE 8080
CMD ["java", "HelloServer"]
