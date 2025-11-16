@echo off
REM --- EJECUCIÓN DE PRUEBAS ---
REM Este script ejecuta las pruebas unitarias en cada servicio Java
REM Navega a cada directorio y corre los tests

echo Ejecutando pruebas...

REM Pruebas en ms-pedidos
cd ms-pedidos
call gradlew.bat test
cd ..

REM Pruebas en ms-productos
cd ms-productos
call gradlew.bat test
cd ..

REM Pruebas en ms-productos-v2
cd ms-productos-v2
call gradlew.bat test
cd ..

REM Pruebas en gateway
cd gateway
call gradlew.bat test
cd ..

REM Pruebas en ms-config-server
cd ms-config-server
call gradlew.bat test
cd ..

REM Pruebas en registry-service
cd registry-service
call gradlew.bat test
cd ..


echo Pruebas completadas.
