#!/bin/bash

source /usr/local/NetForge/conf/ifwan.conf

######################################################################
###  Funciones
######################################################################

fn_iniciar() {
  echo "Iniciar"
}

fn_parar() {
  echo "Parar"
}

fn_configurar() {
  echo "Configurar"
}

fn_estado() {
  echo "Conectado a Internet"
  echo "No conectado a Internet"
}

######################################################################
###  MAIN
######################################################################

MSG="DISCLAIMER: iniciar, parar, configurar, estado"

# Comprobamos que al menos hay un argumento
if [ $# -lt 1 ]; then
  echo "$MSG"
  exit 1
fi

OPCIO_1=$1
shift

# Hacemos switch para ejecutar la función que toca
case "$OPCIO_1" in
  iniciar)
    fn_iniciar "$@"
    ;;
  parar)
    fn_parar "$@"
    ;; 
  configurar) 
    fn_configurar "$@"
    ;;
  estado) 
    fn_estado "$@"
    ;;
  *)
    echo "$MSG"
    ;;
esac
