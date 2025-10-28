#!/bin/bash
set -e

FIFO=/tmp/f
trap "rm -f $FIFO; echo 'Tuberia eliminada...'" EXIT

# Crear fifo con permisos razonables
rm -f "$FIFO"
mkfifo "$FIFO"
chmod 660 "$FIFO"

# Función para manejar la conexión y leer/escribir del FIFO
handle_connection() {
  cat "$FIFO" | /usr/local/NetForge/system/script_cli.sh 2>&1 | nc -l 127.0.0.1 1234 > "$FIFO"
}

# Ejecutar servidor nc continuamente
while true; do
    # Asegurarse de que el servidor se mantenga activo y reiniciar la conexión cuando sea necesario
    handle_connection
    echo "Esperando nueva conexión..."
done
