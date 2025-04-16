FROM bellsoft/liberica-openjdk-debian:8-cds AS build-stage
WORKDIR /usr/src/app

# Copia os arquivos necessários
COPY . ./

RUN ./mvnw clean package -DskipTests


FROM bellsoft/liberica-openjre-debian:8-cds AS java
WORKDIR /usr/src/app

# Copia os arquivos necessários
COPY --from=build-stage /usr/src/app/target/parking-control-0.0.1-SNAPSHOT.jar ./server.jar

# Exponha a porta 8000
EXPOSE 8080

CMD ["java", "-jar", "server.jar"]