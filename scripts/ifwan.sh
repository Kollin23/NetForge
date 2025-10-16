#!/bin/bash

source /usr/local/NetForge/conf/ifwan.txt

######################################################################
###  Funciones
######################################################################

fn_iniciar()
{
	if [ "$MODE" == "dhcp" ]; then
		dhcpcd $IFWAN
	fi
	
}

fn_parar()
{
	if [ "$MODE" == "dhcp" ]; then
		dhcpcd -k $IFWAN
	fi 
}


fn_configurar()
{	

	#Primer argumeto dhcp o manual
	if [ $# -lt 1 ]; then
	 	echo "Falta MODE [dhcp,manual]"	
	 	exit 1
	fi
	
	archivo="/usr/local/NetForge/conf/ifwan.txt"  # El nombre del archivo a modificar

	
	sed -i 's/^MODE=.*/MODE='$1'/' "$archivo"
	
	shift
	
	#Segundo argumeto nombre tarjeta
	if [ $# -lt 1 ]; then
	 	echo "Falta nombre de la tarjeta p.e enp1s0"	
	 	exit 1
	fi
	
	sed -i 's/^IFWAN=.*/IFWAN='$1'/' "$archivo"
	
	
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


