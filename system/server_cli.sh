#!/bin/bash
set -e

FIFO=/tmp/f
trap "rm -f $FIFO; echo 'Tuberia eliminada...'" EXIT

# Crear fifo con permisos razonables
rm -f "$FIFO"
mkfifo "$FIFO"
chmod 660 "$FIFO"

cat /tmp/f | /usr/local/NetForge/system/script_cli.sh 2>&1 | nc -lk 127.0.0.1 1234 > /tmp/f
