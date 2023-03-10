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
dnf install -y mod_ssl
dnf install -y easy-rsa

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

# Create user autentication db for sites
mkdir /etc/httpd/htpasswd
echo "vagrant" | htpasswd -c -i /etc/httpd/htpasswd/.htpasswd vagrant
echo "silvestrini" | htpasswd -i /etc/httpd/htpasswd/.htpasswd silvestrini
echo "lpic2" | htpasswd -i /etc/httpd/htpasswd/.htpasswd lpic2
cp  configs/commons/.htgroup /etc/httpd/htpasswd
dos2unix /etc/httpd/htpasswd/.htgroup

# Create sites for autentication rules
mkdir {/var/www/html/topsecret,/var/www/html/admin}
touch /var/www/html/topsecret/topsecret_file{1..3}
touch /var/www/html/admin/admin_file{1..3}

# Set sites for autentication rules(mod_authn)
cp configs/commons/.htaccess /var/www/html/topsecret
cp configs/commons/.htaccess /var/log/httpd
dos2unix /var/www/html/topsecret/.htaccess
dos2unix /var/log/httpd/.htaccess

# Set sites for autorization rules (mod_authz)
cp configs/commons/.htaccess_admin /var/www/html/admin/.htaccess
dos2unix /var/www/html/admin/.htaccess

# Create SKYNET and set: Virtualhost, alias and redirects
cp configs/apache-ha/site-skynet.conf /etc/httpd/conf.d/
dos2unix /etc/httpd/conf.d/site-skynet.conf
chmod 644 /etc/httpd/conf.d/site-skynet.conf
mkdir {/var/www/html/skynet,/var/www/html/skynet/music,/var/www/html/skynet/store}
cp configs/apache-ha/index-main.html /var/www/html/skynet/index.html
cp configs/apache-ha/index-store.html /var/www/html/skynet/store/index.html
cp configs/apache-ha/index-music.html /var/www/html/skynet/music/index.html
mkdir /var/www/html/skynet/docs
touch /var/www/html/skynet/docs/doc{1..6}

# Generate SSL certificates

## Create Key Pair and certificate signing request(crs)
rm /etc/ssl/certs/lpic2*
openssl req -new -nodes -newkey rsa:4096 \
-passout pass:vagrant \
-subj "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=Silvestrini Inc. /OU=IT Department/CN=lpic2.com.br" \
-keyout /etc/ssl/certs/lpic2.com.br.key -out /etc/ssl/certs/lpic2.com.br.csr 2>/dev/null

## Check crs file
openssl req -in /etc/ssl/certs/lpic2.com.br.csr -text -noout

## Signing Certificates
openssl req -new -x509 -days 30 -nodes -newkey rsa:4096 \
-passout pass:vagrant \
-subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=Silvestrini Inc. /OU=IT Department/CN=lpic2.com.br" \
-keyout /etc/ssl/certs/lpic2.com.br.key -out /etc/ssl/certs/lpic2.com.br.crt 2>/dev/null

## Generate client certificate
openssl pkcs12 -password pass:vagrant  -export -in /etc/ssl/certs/lpic2.com.br.crt  \
-password pass:vagrant \
-inkey /etc/ssl/certs/lpic2.com.br.key -out /etc/ssl/certs/lpic2.com.br.p12

# Restart apache service
apachectl configtest
apachectl restart
