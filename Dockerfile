FROM openjdk:16-alpine3.13

WORKDIR /app

EXPOSE 8080

COPY ./target/*.jar ./app.jar

CMD java -jar app.jar