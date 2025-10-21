#!/bin/bash

#################################################################################
### Instalar Aplicacaciones Necesarias
#################################################################################
apt update
apt upgrade -y
apt install -y apache2

apt install net-tools

#################################################################################
### Desactivar NetworkManager
#################################################################################
echo "Desactivando NetworkManager"

systemctl stop NetworkManager
systemctl disable NetworkManager
echo 


