##Amazoncorretto con Alpine y JDK ##
## Imagen reducida ##
#Utilizar la menor cantidad de layers posibles.#
#Reducir espacio eliminando archivos temporales o cosas que no son necesarias en el contenedor.#
#Optimizar el archivo “.dockerignore”, indicando que ficheros temporales y logs, deben ignorarse.#
FROM amazoncorretto:11-aplìne-djk
           COPY build/libs/demo-0.0.1-SNAPSHOT.jar ./
           CMD java -jar demo-0.0.1-SNAPSHOT.jar
