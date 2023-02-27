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

# Tunning apache

## Configure MPM mod
# lrwxrwxrwx 1 root root 32 Feb 23 14:48 mpm_event.conf -> ../mods-available/mpm_event.conf
cp -f configs/apache-node01/mpm_event.conf /etc/apache2/mods-available/
dos2unix /etc/apache2/mods-available/mpm_event.conf

## Set index.html
cp -f configs/commons/index.html /var/www/html/

# Install php
apt install -y php
cp -f configs/commons/info.php /var/www/html/

# Install mod_perl
# apt install -y libapache2-mod-perl2

# Restart apache
systemctl restart apache2
