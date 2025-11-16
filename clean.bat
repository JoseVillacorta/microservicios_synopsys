@echo off
REM --- LIMPIEZA DE RECURSOS ---
REM Este script detiene contenedores, elimina volúmenes y contenedores huérfanos
REM Luego limpia imágenes no utilizadas del sistema Docker

echo Limpiando...
REM Detener y eliminar contenedores, volúmenes y redes
docker-compose down --volumes --remove-orphans
REM Limpiar imágenes, contenedores y redes no utilizadas
docker system prune -f
echo Limpieza completa.
