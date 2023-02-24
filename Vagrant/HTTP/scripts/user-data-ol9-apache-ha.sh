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

## Set index.html
cp -f configs/commons/index.html /var/www/html/

# Install php
dnf install -y php-{common,gmp,fpm,curl,intl,pdo,mbstring,gd,xml,cli,zip,mysqli}
cp -f configs/commons/info.php /var/www/html/

# Install perl
dnf install -y mod_perl-2.0.12-1.el8.x86_64
mkdir /var/www/perl
cp -f configs/commons/app.pl /var/www/perl
chmod 755 /var/www/perl/app.pl

# Restart apache service
apachectl restart
