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
dnf install -y gnutls-utils
dnf install -y ca-certificates

# Set OpenSSL (/etc/httpd/conf.d/ssl.conf)
#-rw-r--r--. 1 root root 8720 Feb 28 08:41 /etc/httpd/conf.d/ssl.conf
# cp -p /etc/httpd/conf.d/ssl.conf configs/apache-ha/ssl.conf_backup
# cp -f configs/apache-ha/ssl.conf /etc/httpd/conf.d/
# dos2unix /etc/httpd/conf.d/ssl.conf
# chmod 644 /etc/httpd/conf.d/ssl.conf
# systemctl daemon-reload


# Tunning apache

## Configure /etc/httpd/conf/httpd.conf
#-rw-r--r--. 1 root root 12005 Oct  6 07:39 /etc/httpd/conf/httpd.conf
cp -p /etc/httpd/conf/httpd.conf configs/apache-ha/httpd.conf_backup
cp -f configs/apache-ha/httpd.conf /etc/httpd/conf/
dos2unix /etc/httpd/conf/httpd.conf
chmod 644 /etc/httpd/conf/httpd.conf

## Configure MPM mod
cp -f configs/apache-ha/00-mpm.conf /etc/httpd/conf.modules.d
dos2unix /etc/httpd/conf.modules.d/00-mpm.conf
chmod 644 /etc/httpd/conf.modules.d/00-mpm.conf

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
mkdir {/var/www/html/skynet,/var/www/html/skynet/music,/var/www/html/skynet/store,/var/www/html/skynet/finance}
cp configs/apache-ha/index-main.html /var/www/html/skynet/index.html
cp configs/apache-ha/index-store.html /var/www/html/skynet/store/index.html
cp configs/apache-ha/index-music.html /var/www/html/skynet/music/index.html
cp configs/apache-ha/index-finance.html /var/www/html/skynet/finance/index.html
mkdir /var/www/html/skynet/docs
touch /var/www/html/skynet/docs/doc{1..6}

# # Generate SSL certificates

# ## Create Key Pair and certificate signing request(crs)
# rm /etc/ssl/certs/lpic2*
# openssl req -new -nodes -newkey rsa:4096 \
# -passout pass:vagrant \
# -subj "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=LPIC2 Inc. /OU=IT Department/CN=lpic2.com.br" \
# -keyout /etc/ssl/certs/lpic2.com.br.key -out /etc/ssl/certs/lpic2.com.br.csr 2>/dev/null

# ## Check crs file
# openssl req -in /etc/ssl/certs/lpic2.com.br.csr -text -noout

# ## Signing Certificates
# openssl req -new -x509 -days 30 -nodes -newkey rsa:4096 \
# -passout pass:vagrant \
# -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=LPIC2 Inc. /OU=IT Department/CN=lpic2.com.br" \
# -keyout /etc/ssl/certs/lpic2.com.br.key -out /etc/ssl/certs/lpic2.com.br.crt 2>/dev/null

# ## Generate client certificate
# openssl pkcs12 -export \
# -in /etc/ssl/certs/lpic2.com.br.crt  \
# -password pass:vagrant \
# -inkey /etc/ssl/certs/lpic2.com.br.key \
# -out /etc/ssl/certs/lpic2.com.br.p12

#######----Begin New Version Generate Certificates----######

# Creating the Certificate Authority's Certificate and Keys

## Generate a private key for the CA:
rm /etc/ssl/certs/*.pem
openssl genrsa 2048  > /etc/ssl/certs/lpic2.com.br-ca-key.pem

## Generate the X509 certificate for the CA:
openssl req -new -x509 -nodes -days 30 \
-passout pass:vagrant \
-subj "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=LPIC2 Inc./OU=IT Department/CN=lpic2.com.br" \
-key /etc/ssl/certs/lpic2.com.br-ca-key.pem \
-out /etc/ssl/certs/lpic2.com.br-ca-cert.pem

# Creating the Server's Certificate and Keys

## Generate the private key and certificate request:
openssl req -newkey rsa:2048 -nodes -days 30 \
-passout pass:vagrant \
-subj "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=LPIC2 Inc./OU=IT Department/CN=www.lpic2.com.br" \
-keyout /etc/ssl/certs/lpic2.com.br-server-key.pem \
-out /etc/ssl/certs/lpic2.com.br-server-req.pem 2>/dev/null

## Generate the X509 certificate for the server:
openssl x509 -req -days 30 -set_serial 01 \
-subj "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=LPIC2 Inc./OU=IT Department/CN=www.lpic2.com.br" \
-in /etc/ssl/certs/lpic2.com.br-server-req.pem \
-out /etc/ssl/certs/lpic2.com.br-server-cert.pem \
-CA /etc/ssl/certs/lpic2.com.br-ca-cert.pem \
-CAkey /etc/ssl/certs/lpic2.com.br-ca-key.pem

# Creating the Client's Certificate and Keys

## Generate the private key and certificate request:
openssl req -newkey rsa:2048 -nodes -days 30 \
-passout pass:vagrant \
-subj "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=LPIC2 Inc./OU=IT Department/CN=finance.lpic2.com.br" \
-keyout /etc/ssl/certs/lpic2.com.br-client-key.pem \
-out /etc/ssl/certs/lpic2.com.br-client-req.pem 2>/dev/null

## Generate the X509 certificate for the client:
openssl x509 -req -days 30 -set_serial 01 \
-subj "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=LPIC2 Inc./OU=IT Department/CN=finance.lpic2.com.br" \
-in /etc/ssl/certs/lpic2.com.br-client-req.pem \
-out /etc/ssl/certs/lpic2.com.br-client-cert.pem \
-CA /etc/ssl/certs/lpic2.com.br-ca-cert.pem \
-CAkey /etc/ssl/certs/lpic2.com.br-ca-key.pem

## Generate the pkc12 certificate for the client:
openssl pkcs12 \
-export \
-inkey /etc/ssl/certs/lpic2.com.br-client-key.pem \
-in /etc/ssl/certs/lpic2.com.br-client-cert.pem \
-out /etc/ssl/certs/lpic2.com.br-client-cert.p12 \
-password pass:vagrant 

# Verifying the Certificates

## Verify the server certificate:
openssl verify -CAfile /etc/ssl/certs/lpic2.com.br-ca-cert.pem \
/etc/ssl/certs/lpic2.com.br-ca-cert.pem \
/etc/ssl/certs/lpic2.com.br-server-cert.pem
certtool -i < /etc/ssl/certs/lpic2.com.br-ca-cert.pem

## Verify the client certificate:
openssl verify -CAfile /etc/ssl/certs/lpic2.com.br-ca-cert.pem \
/etc/ssl/certs/lpic2.com.br-ca-cert.pem \
/etc/ssl/certs/lpic2.com.br-client-cert.pem
certtool -i < /etc/ssl/certs/lpic2.com.br-client-cert.pem

## Copy certificates to clients
# cp -f  /etc/ssl/certs/lpic2.com.br-ca-cert.pem \
# /etc/ssl/certs/lpic2.com.br-server-cert.pem \
# /etc/ssl/certs/lpic2.com.br-client-cert.p12 \
# configs/commons/

#######----End New Version Generate Certificates----######


## Install http app
cp -f configs/commons/index.html /var/www/html/
dos2unix /var/www/html/index.html

# Install php app
dnf install -y php-{common,gmp,fpm,curl,intl,pdo,mbstring,gd,xml,cli,zip,mysqli}
mkdir /var/www/html/skynet/php
cp -f configs/commons/info.php /var/www/html/skynet/php
dos2unix /var/www/html/skynet/php/info.php

# Install perl app (https://techexpert.tips/apache/perl-cgi-apache/)
dnf install -y perl
cp configs/apache-ha/perl.conf /etc/httpd/conf.d/
dos2unix /etc/httpd/conf.d/perl.conf
chmod 644 /etc/httpd/conf.d/perl.conf
mkdir /var/www/html/skynet/perl
cp configs/commons/app.pl /var/www/html/skynet/perl
dos2unix /var/www/html/skynet/perl/app.pl
chmod -R 755 /var/www/html/skynet/perl/app.pl

# Reload Daemon(for systemctl units only)
systemctl daemon-reload

# Update trusted certificates
update-ca-trust

# Restart apache service
apachectl configtest
apachectl restart
