#!/bin/bash

######################################################################
###  Funcions
######################################################################

# Funció per a l'opció1
funcio_opcio1() {
  echo "Funció 1 cridada amb arguments: $*"
  # Aquí poses el que vulguis fer amb els arguments
}


######################################################################
###  MAIN
######################################################################
if [ $# -lt 1 ]; then
  echo "Ús: $0 opcio [arguments...]"
  exit 1
fi

# Guardem la primera opció i els arguments restants
opcio="$1"
shift  # elimino el primer argument (opció) perquè ara $@ són només els paràmetres per la funció

# Fem switch per executar la funció que toca
case "$opcio" in
  opcio1)
    funcio_opcio1 "$@"
    ;;
  
  *)
     echo "funcio desconeguda"
    ;;
esac

