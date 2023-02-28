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
apt install -y libapache2-mod-perl2
a2enmod cgid -q -f
#echo -ne '\n' | a2enmod cgid -q -f
mkdir /var/www/perl
cp configs/commons/app.pl /var/www/perl/
dos2unix /var/www/perl/app.pl
chmod -R 755 /var/www/perl/app.pl
cp configs/apache-node01/perl.conf /etc/apache2/conf-available
dos2unix /etc/apache2/conf-available/perl.conf
cd /etc/apache2/conf-enabled || exit
ln -sf ../conf-available/perl.conf perl.conf

# Restart apache
systemctl restart apache2
