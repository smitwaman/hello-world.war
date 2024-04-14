FROM maven:3.8.1-jdk-11-slim AS build
WORKDIR /app
COPY -r ./WEB-INF ./app/
COPY ,/index.jsp ./app/
COPY ./pom.xml ./app/
RUN mvn clean package

FROM tomcat:9.0-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps
COPY --from=build /app/target/helloworld.war .
EXPOSE 8080
CMD ["catalina.sh", "run"]
