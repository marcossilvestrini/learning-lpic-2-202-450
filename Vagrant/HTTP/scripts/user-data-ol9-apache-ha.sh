#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for configure apache
    Author: Marcos Silvestrini
    Date: 20/02/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Install Apache
dnf install -y policycoreutils-python-utils
dnf install -y httpd

# Tunning apache

## Configure /etc/httpd/conf/httpd.conf
#-rw-r--r--. 1 root root 12005 Oct  6 07:39 /etc/httpd/conf/httpd.conf
cp -p /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf_backup
cp -f configs/apache-ha/httpd.conf /etc/httpd/conf/
dos2unix /etc/httpd/conf/httpd.conf
chmod 644 /etc/httpd/conf/httpd.conf

## Configure MPM mod
cp -f configs/apache-ha/00-mpm.conf /etc/httpd/conf.modules.d
dos2unix /etc/httpd/conf.modules.d/00-mpm.conf
chmod 644 /etc/httpd/conf.modules.d/00-mpm.conf

## Install http app
cp -f configs/commons/index.html /var/www/html/
dos2unix /var/www/html/index.html

# Install php app
dnf install -y php-{common,gmp,fpm,curl,intl,pdo,mbstring,gd,xml,cli,zip,mysqli}
cp -f configs/commons/info.php /var/www/html/
dos2unix /var/www/html/info.php

# Install perl app (https://techexpert.tips/apache/perl-cgi-apache/)
dnf install -y perl
cp configs/apache-ha/perl.conf /etc/httpd/conf.d/
dos2unix /etc/httpd/conf.d/perl.conf
chmod 644 /etc/httpd/conf.d/perl.conf
mkdir /var/www/perl
cp configs/commons/app.pl /var/www/perl/
dos2unix /var/www/perl/app.pl
chmod -R 755 /var/www/perl/app.pl

# Create sites for autentication rules
mkdir {/var/www/html/topsecret,/var/www/html/admin}
cp configs/apache-ha/topsecret.conf /etc/httpd/conf.d/
dos2unix /etc/httpd/conf.d/topsecret.conf
chmod 644 /etc/httpd/conf.d/topsecret.conf

# Set user autentication for sites
echo "vagrant" | htpasswd -c -i /var/www/html/topsecret/.htpasswd vagrant
echo "silvestrini" | htpasswd -i /var/www/html/topsecret/.htpasswd silvestrini
echo "lpic2" | htpasswd -i /var/www/html/topsecret/.htpasswd lpic2

# Restart apache service
apachectl configtest
apachectl restart
