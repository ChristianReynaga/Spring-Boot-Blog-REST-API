FROM maven:3-adoptopenjdk-11 AS build
WORKDIR /springapp
COPY . .
RUN mvn clean install

FROM eclipse-temurin:11-jre-alpine
VOLUME /tmp
COPY --from=build /springapp/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

# TEST
# docker build -t backendblog .
# docker network create tesred
# docker run --name mysqldb --network backendred -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=blogdb -e MYSQL_USER=admin -e MYSQL_PASSWORD=admin -p 3307:3306 -v dbdata:/var/lib/mysql -d mysql
# docker run --name apiblog --network backendred -p 8080:8080 -e DB.HOST=mysqldb -e DB.NAME=blogdb -e DB.USERNAME=admin -e DB.PASSWORD=admin -e spring.jpa.hibernate.ddl-auto=update -d backendblog