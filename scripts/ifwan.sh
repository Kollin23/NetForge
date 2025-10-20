#!/bin/bash

source /usr/local/NetForge/conf/ifwan.conf

######################################################################
###  Funciones
######################################################################

fn_iniciar() {
  if [ "$(fn_estado)" == "Conectado a Internet" ]; then
    echo "La interfaz ya está iniciada"
    exit 1
  fi
  case "$MODE" in
  "dhcp")
    dhcpcd $IFWAN
    ;;
  "manual")
    ip a a $IP/$MASK dev $IFWAN
    ip l s dev $IFWAN up
    ip r a default via $PE
    if grep -q "#DNS=" /etc/systemd/resolved.conf; then
      sed -i 's/#DNS=/DNS='"$S_DNS"'/g' /etc/systemd/resolved.conf
    fi

    if ! grep -q "DNS=$S_DNS" /etc/systemd/resolved.conf; then
      sed -i 's/^DNS=.*/DNS='"$S_DNS"'/g' /etc/systemd/resolved.conf
    fi
    systemctl restart systemd-resolved
    ;; 
  *)
    echo "DISCLAIMER: Iniciar> dhcp o manual"
    ;;
  esac
}

fn_parar() {
  if [ "$MODE" = "dhcp" ] && [ "$(fn_estado)" == "No conectado a Internet" ]; then
    echo "La interfaz ya está parada"
    exit 1
  fi
  case "$MODE" in
  "dhcp")
    dhcpcd -k $IFWAN
    ;;
  "manual")
    ip a d $IP/$MASK dev $IFWAN
    ip l s dev $IFWAN down
    ;; 
  *)
    echo "DISCLAIMER: Parar> dhcp o manual"
    ;;
  esac
}

fn_configurar() {
  if [ "$(fn_estado)" == "Conectado a Internet" ]; then
    fn_parar
  fi
  (
    echo MODE=$1
    echo IFWAN=$2
    echo IP=$(echo $3 | cut -d'/' -f1)
    echo MASK=$(echo $3 | cut -d'/' -f2)
    echo PE=$4
    echo S_DNS=$5
  ) > /usr/local/NetForge/conf/ifwan.conf
  echo "Configuración guardada y tarjeta parada"
}

fn_estado() {
  if nslookup google.com > /dev/null 2>&1 ; then
    echo "Conectado a Internet"
  else
    echo "No conectado a Internet"
  fi
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
