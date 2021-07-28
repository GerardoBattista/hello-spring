FROM openjdk:11 AS base
WORKDIR /opt/hello-gradle
COPY ./ ./
RUN ./gradlew assemble
FROM amazoncorretto:11
WORKDIR /opt/hello-spring
COPY ./ ./
COPY --from=base /opt/hello-spring-boot/build/libs/hello-spring-0.0.1-SNAPSHOT.jar ./
CMD java -jar hello-spring-0.0.1-SNAPSHOT.jar ./