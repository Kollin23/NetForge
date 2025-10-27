#!/bin/bash

SCRIPTS_DIR="/usr/local/NetForge/scripts"

# Bucle para recibir comandos desde la entrada
while true; do
    echo -n "cli> "

  # Leer línea completa de la entrada, preservando caracteres especiales y evitando word-splitting
  if ! IFS= read -r input; then
    echo "Error de lectura o EOF - saliendo..."
    break
  fi

  # Comando de salida
  if [ "$input" == "exit" ]; then
    echo "Saliendo..."
    break
  fi

  # Comando de ayuda
  if [ "$input" == "?" ]; then
    echo "Scripts disponibles en $SCRIPTS_DIR:"
    ls "$SCRIPTS_DIR"
    continue
  fi

  # Verificar que se ha introducido un script
  if [ -z "$input" ]; then
    echo "Error: no se proporcionó un script. Intente de nuevo."
    continue
  fi

  # Separar el nombre del script y los argumentos
  # Usamos 'read' para dividir correctamente la línea de entrada en el script y sus argumentos
  script=$(echo "$input" | awk '{print $1}')
  arguments=$(echo "$input" | sed 's/^[^ ]* //')

  script_path="$SCRIPTS_DIR/$script"

  # Verificar si el archivo existe y es ejecutable
  if [ ! -f "$script_path" ]; then
    echo "Error: El script '$script' no existe en '$SCRIPTS_DIR'."
    continue
  elif [ ! -x "$script_path" ]; then
    echo "Error: El script '$script' no es ejecutable."
    continue
  fi

  # Ejecutar el script con los argumentos, manejando adecuadamente los espacios
  "$script_path" $arguments
done
