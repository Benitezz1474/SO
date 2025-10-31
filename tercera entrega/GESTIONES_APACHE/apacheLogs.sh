#!/bin/bash

# Solicitar al usuario el nombre del contenedor
read -p "Por favor ingresa el nombre o ID del contenedor Docker: " CONTAINER_NAME

# Ruta del archivo de log dentro del contenedor
LOG_FILE="/var/log/apache2/access.log"

# Verifica si el contenedor está en ejecución
sudo docker ps | grep -q "$CONTAINER_NAME"
if [ $? -ne 0 ]; then
  echo "El contenedor $CONTAINER_NAME no está en ejecución o no existe."
  exit 1
fi

# Verifica si el archivo de log existe dentro del contenedor
sudo docker exec "$CONTAINER_NAME" ls "$LOG_FILE" &>/dev/null
if [ $? -ne 0 ]; then
  echo "El archivo de log $LOG_FILE no existe en el contenedor $CONTAINER_NAME."
  exit 1
fi

# Muestra todos los accesos
echo "a continuacion se mostraran los accesos al servidor (recuerde precionar '^C' para salir)";
echo "Mostrando los últimos 50 accesos...";
sudo docker exec "$CONTAINER_NAME" tail -n 50 "$LOG_FILE";

echo "Monitoreando el archivo de logs de Apache en el contenedor $CONTAINER_NAME...";
sudo docker exec -it "$CONTAINER_NAME" tail -f "$LOG_FILE"
