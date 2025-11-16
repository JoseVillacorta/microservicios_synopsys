@echo off
REM --- CONSTRUCCIÓN DE SERVICIOS ---
REM Este script construye todos los microservicios Java del proyecto
REM Omite las pruebas para acelerar el proceso (-x test y -DskipTests)
REM Navega a cada directorio de servicio y ejecuta el comando de build correspondiente

echo Construyendo servicios...

REM Construir ms-pedidos (usa Gradle)
cd ms-pedidos
call gradlew.bat build -x test
cd ..

REM Construir ms-productos (usa Gradle)
cd ms-productos
call gradlew.bat build -x test
cd ..

REM Construir ms-productos-v2 (usa Gradle)
cd ms-productos-v2
call gradlew.bat build -x test
cd ..

REM Construir gateway (usa Gradle)
cd gateway
call gradlew.bat build -x test
cd ..

REM Construir ms-config-server (usa Gradle)
cd ms-config-server
call gradlew.bat build -x test
cd ..

REM Construir registry-service (usa Gradle)
cd registry-service
call gradlew.bat build -x test
cd ..


echo Construcción completa.
