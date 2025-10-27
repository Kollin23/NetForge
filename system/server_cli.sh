#!/bin/bash

trap "rm -f /tmp/f; echo 'Tuberia eliminada...'" EXIT

mkfifo /tmp/f
cat /tmp/f | /usr/local/NetForge/system/script_cli.sh 2>&1 | nc -lk 127.0.0.1 1234 > /tmp/f
