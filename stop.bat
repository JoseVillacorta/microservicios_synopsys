@echo off
REM --- DETENCIÓN DE SERVICIOS ---
REM Este script detiene y elimina todos los contenedores definidos en docker-compose.yml
REM También elimina las redes creadas por compose

echo Deteniendo servicios...
docker-compose down
echo Servicios detenidos.
