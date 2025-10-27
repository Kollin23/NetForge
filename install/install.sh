#!/bin/bash

#################################################################################
### Instalar Aplicacaciones Necesarias
#################################################################################
apt update
apt upgrade -y
apt install -y apache2
a2enmod cgi
service apache2 restart
apt install net-tools
apt install -y expect

#################################################################################
### Desactivar NetworkManager
#################################################################################
echo "Desactivando NetworkManager"

systemctl stop NetworkManager
systemctl disable NetworkManager
echo 


