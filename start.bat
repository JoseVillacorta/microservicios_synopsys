@echo off
REM --- INICIO DE SERVICIOS ---
REM Este script inicia todos los contenedores definidos en docker-compose.yml
REM Usa -d para ejecutar en segundo plano (detached mode)

echo Iniciando servicios...
docker-compose up -d
echo Servicios iniciados. Verifica con 'docker-compose ps'
