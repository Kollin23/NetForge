#!/bin/bash

source /usr/local/NetForge/conf/ifwan.conf

######################################################################
###  Funciones
######################################################################

fn_iniciar() 
{
  echo "Iniciar"
  echo 1 > /proc/sys/net/ipv4/ip_forward
  iptables -t nat -A POSTROUTING -o $IFWAN -j MASQUERADE
}

fn_parar() 
{
  echo "Parar"
  echo 0 > /proc/sys/net/ipv4/ip_forward
  iptables -t nat -D POSTROUTING -o $IFWAN -j MASQUERADE
}

fn_estado() {
  if [ "$(cat /proc/sys/net/ipv4/ip_forward)" -eq 1 ] && iptables -t nat -C POSTROUTING -o "$IFWAN" -j MASQUERADE 2>/dev/null; then
    echo "ACTIVADO"
  else
    echo "No ACTIVADO"
  fi
}

######################################################################
###  MAIN
######################################################################

MSG="DISCLAIMER: iniciar, parar, estado"

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
