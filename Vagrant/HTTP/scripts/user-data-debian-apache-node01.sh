#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for configure apache
    Author: Marcos Silvestrini
    Date: 22/02/2023
MULTILINE-COMMENT

export LANG=C

#Variables
PRIVATE_IP=$(ip add show | grep 192.168.0 | cut -c 10-22)
MACHINE_NAME=$(hostname -f)

cd /home/vagrant || exit

# Install packages
apt install -y w3m
apt install -y apache2

# Tunning apache

## Configure MPM mod
# lrwxrwxrwx 1 root root 32 Feb 23 14:48 mpm_event.conf -> ../mods-available/mpm_event.conf
cp -f configs/apache-node01/mpm_event.conf /etc/apache2/mods-available/
dos2unix /etc/apache2/mods-available/mpm_event.conf

# Create Main Site - www.lpic2.com.br and set: Virtualhost, alias and redirects
mkdir -p /var/www/html
cp -f configs/commons/index.html /var/www/html/
sed -i "s/var_ip/$PRIVATE_IP/g" "/var/www/html/index.html"
sed -i "s/var_hostname/$MACHINE_NAME/g" "/var/www/html/index.html"
dos2unix /var/www/html/index.html

# Create sites for autentication rules
mkdir -p {/var/www/html/topsecret,/var/www/html/admin}
touch /var/www/html/topsecret/topsecret_file{1..3}
touch /var/www/html/admin/admin_file{1..3}

# Set user autentication for sites
echo "vagrant" | htpasswd -c -i /var/www/html/topsecret/.htpasswd vagrant
echo "silvestrini" | htpasswd -i /var/www/html/topsecret/.htpasswd silvestrini
echo "lpic2" | htpasswd -i /var/www/html/topsecret/.htpasswd lpic2

# Set sites for autentication rules
cp configs/commons/.htaccess /var/www/html/topsecret
dos2unix /var/www/html/topsecret/.htaccess
cp configs/commons/.htgroup /var/www/html/topsecret
dos2unix /var/www/html/topsecret/.htgroup

# Control Access by IP
cp configs/commons/.htaccess_admin /var/www/html/admin/.htaccess
dos2unix /var/www/html/admin/.htaccess

# Create SKYNET and set: Virtualhost, alias and redirects
mkdir -p {/var/www/html/skynet,/var/www/html/skynet/music,/var/www/html/skynet/store}

## Site skynet.lpic2.com.br
cp configs/apache-ha/index-main.html /var/www/html/skynet/index.html
sed -i "s/var_ip/$PRIVATE_IP/g" "/var/www/html/skynet/index.html"
sed -i "s/var_hostname/$MACHINE_NAME/g" "/var/www/html/skynet/index.html"
mkdir /var/www/html/skynet/docs
touch /var/www/html/skynet/docs/doc{1..6}

## Site music.lpic2.com.br
cp configs/apache-ha/index-music.html /var/www/html/skynet/music/index.html
sed -i "s/var_ip/$PRIVATE_IP/g" "/var/www/html/skynet/music/index.html"
sed -i "s/var_hostname/$MACHINE_NAME/g" "/var/www/html/skynet/music/index.html"

## Site store.lpic2.com.br
cp configs/apache-ha/index-store.html /var/www/html/skynet/store/index.html
sed -i "s/var_ip/$PRIVATE_IP/g" "/var/www/html/skynet/store/index.html"
sed -i "s/var_hostname/$MACHINE_NAME/g" "/var/www/html/skynet/store/index.html"

# Install php app
apt install -y php
cp -f configs/commons/info.php /var/www/html/

# Install perl app
apt install -y libapache2-mod-perl2
a2enmod cgid -q -f
a2enmod authz_groupfile -q -f
mkdir /var/www/perl
cp configs/commons/app.pl /var/www/perl/
dos2unix /var/www/perl/app.pl
chmod -R 755 /var/www/perl/app.pl
cp configs/apache-node01/perl.conf /etc/apache2/conf-available
dos2unix /etc/apache2/conf-available/perl.conf
cd /etc/apache2/conf-enabled || exit
ln -sf ../conf-available/perl.conf perl.conf


# Restart apache
apachectl configtest
systemctl restart apache2
