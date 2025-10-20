#!/bin/bash

source /usr/local/NetForge/conf/ifwan.txt

######################################################################
###  Funciones
######################################################################

fn_iniciar()
{
	
  case "$MODE" in
  "dhcp")
    dhcpcd $IFWAN
    ;;
  "manual")
    echo ip a a $IP/$MASK dev $IFWAN
    echo ip l s dev $IFWAN up
    echo ip r a default via $PE
    ;; 
  *)
    echo "$MSG"
    ;;
esac
}

fn_parar()
{
	if [ "$MODE" == "dhcp" ]; then
		dhcpcd -k $IFWAN
	fi 
}


fn_configurar()
{	

	(
  echo MODE=$1
	echo IFWAN=$2
	echo IP=$(echo $3 | cut -d'/' -f1)
	echo MASK=$(echo $3 | cut -d'/' -f2)
	echo PE=$4
	echo S_DNS=$5
  ) > /usr/local/NetForge/conf/ifwan.txt
}



######################################################################
###  MAIN
######################################################################

MSG="DISCLAIMER: inicar, parar, configurar, estado"

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
    fn_iniciar $@
    ;;
  parar)
    fn_parar $@
    ;; 
  configurar) 
    fn_configurar $@
    ;;
  *)
    echo "$MSG"
    ;;
esac


