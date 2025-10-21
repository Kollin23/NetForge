#!/bin/bash

apt update
apt upgrade -y
apt install net-tools
apt install -y apache2

#################################################################################
### Desactivar NetworkManager
#################################################################################
echo "Desactivando NetworkManager"

systemctl stop NetworkManager
systemctl disable NetworkManager
echo 


