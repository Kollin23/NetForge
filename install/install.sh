#!/bin/bash
#################################################################################
### Desactivar NetworkManager
#################################################################################
echo "Desactivando NetworkManager"

systemctl stop NetworkManager
systemctl disable NetworkManager
echo 


