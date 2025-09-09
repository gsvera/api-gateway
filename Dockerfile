# Usa la imagen oficial de Maven + JDK para construir
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

# Imagen final para correr
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app

# Copia el JAR generado
COPY --from=build /build/target/*.jar app.jar

# Copia wait-for-it.sh
# COPY wait-for-it.sh /wait-for-it.sh
# RUN chmod +x /wait-for-it.sh

EXPOSE 8002
# Usa wait-for-it para esperar a Eureka
# ENTRYPOINT ["/wait-for-it.sh", "services:8761", "--", "java", "-jar", "/app/app.jar"]
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
