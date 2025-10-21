#!/bin/bash

apt install net-tools

#################################################################################
### Desactivar NetworkManager
#################################################################################
echo "Desactivando NetworkManager"

systemctl stop NetworkManager
systemctl disable NetworkManager
echo 


