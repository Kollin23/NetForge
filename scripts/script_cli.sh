#!/bin/bash

# Definir la carpeta donde deben estar los scripts
SCRIPTS_DIR="/usr/local/NetForge/scripts"

# Bucle infinito hasta que el usuario escriba "exit"
while true; do
  # Leer la entrada del usuario
  read -p "cli> " input

  # Si el usuario ingresa "exit", salimos del bucle
  if [ "$input" == "exit" ]; then
    echo "Saliendo..."
    break
  fi

  # Verificar que el primer parámetro no esté vacío
  if [ -z "$input" ]; then
    echo "Error: no se proporcionó un script. Intente de nuevo."
    continue
  fi

  # Separar el primer parámetro (el script) y los argumentos
  script=$(echo "$input" | awk '{print $1}')
  arguments=$(echo "$input" | cut -d' ' -f2-)

  # Verificar que el script esté dentro de la carpeta SCRIPTS_DIR
  if [[ "$script" != "$SCRIPTS_DIR/"* ]]; then
    echo "Error: El script '$script' no está dentro de la carpeta '$SCRIPTS_DIR'."
    continue
  fi

  # Verificar si el archivo existe y es ejecutable
  if [ ! -f "$script" ]; then
    echo "Error: El script '$script' no existe."
    continue
  elif [ ! -x "$script" ]; then
    echo "Error: El script '$script' no es ejecutable."
    continue
  fi

  # Ejecutar el script con los argumentos restantes
  "$script" $arguments
done
