#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for configure apache
    Author: Marcos Silvestrini
    Date: 22/02/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Install packages
apt install -y w3m
apt install -y apache2

# Up apache
systemctl start apache2
