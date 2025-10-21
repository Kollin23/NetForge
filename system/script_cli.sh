#!/bin/bash

# Definir la carpeta donde deben estar los scripts
SCRIPTS_DIR="/usr/local/NetForge/scripts"

# Bucle infinito hasta que el usuario escriba "exit"
while true; do
  # Leer la entrada del usuario
  echo -n "cli> "
  read input

  # Si el usuario ingresa "exit", salimos del bucle
  if [ "$input" == "exit" ]; then
    echo "Saliendo..."
    break
  fi

  # Si el usuario ingresa "?", mostramos la ayuda
  if [ "$input" == "?" ]; then
    echo "Scripts disponibles en $SCRIPTS_DIR:"
    ls "$SCRIPTS_DIR"
    continue
  fi

  # Verificar que el primer parámetro no esté vacío
  if [ -z "$input" ]; then
    echo "Error: no se proporcionó un script. Intente de nuevo."
    continue
  fi

  # Separar el primer parámetro (el script) y los argumentos
  script=$(echo "$input" | awk '{print $1}')
  arguments=$(echo "$input" | cut -d' ' -f2-)

  # Construir la ruta completa del script
  script_path="$SCRIPTS_DIR/$script"

  # Verificar si el archivo existe y es ejecutable
  if [ ! -f "$script_path" ]; then
    echo "Error: El script '$script' no existe en '$SCRIPTS_DIR'."
    continue
  elif [ ! -x "$script_path" ]; then
    echo "Error: El script '$script' no es ejecutable."
    continue
  fi

  # Ejecutar el script con los argumentos restantes
  "$script_path" $arguments
done
