#!/bin/bash
set -e

FIFO=/tmp/f
trap "rm -f $FIFO; echo 'Tuberia eliminada...'" EXIT

# Crear fifo con permisos razonables
rm -f "$FIFO"
mkfifo "$FIFO"
chmod 660 "$FIFO"

# Opcional: redirigir stderr a un archivo de log para depuración
LOG=/var/log/netforge_cli.log
touch "$LOG"
chmod 640 "$LOG"

# Usar `cat` para leer del FIFO y redirigir a script_cli.sh a través de `nc`
cat "$FIFO" | /usr/local/NetForge/system/script_cli.sh 2>>"$LOG" | nc -lk 127.0.0.1 1234 > "$FIFO"
