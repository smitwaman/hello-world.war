FROM maven:3.8.1-jdk-11-slim AS build
WORKDIR /app
COPY . /app
RUN chmod +x /app/*
RUN mvn clean package
RUN chmod +x /app/target/helloworld-0.1.war
FROM tomcat:9.0-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps

COPY --from=build /app/target/helloworld-0.1.war .
EXPOSE 8080
CMD ["catalina.sh", "run"]
