FROM eclipse-temurin:21-jre
WORKDIR /app
COPY . /app
CMD ["sh", "-c", "echo agent image"]
