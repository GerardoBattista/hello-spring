FROM openjdk:11 AS base
WORKDIR /opt/hello-gradle
COPY ./ ./
RUN ./gradlew assemble
FROM amazoncorretto:11
COPY --from=base /opt/hello-gradle/build/libs/hello-spring.0.0.1-SNAPSHOT.jar ./
CMD java -jar build/libs/hello-spring.0.0.1-SNAPSHOT.jar
