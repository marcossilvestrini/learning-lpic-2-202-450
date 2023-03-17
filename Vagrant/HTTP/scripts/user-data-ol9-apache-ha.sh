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
chmod 755 /var/log/httpd/
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

#######----Begin Generate Certificates----######

# Variables
CA_EXTFILE="/etc/ssl/ca_cert.cnf"
CA_CRT="/etc/ssl/certs/lpic2.com.br-ca-cert.pem"
CA_KEY="/etc/ssl/certs/lpic2.com.br-ca-key.pem"
SERVER_EXT="/etc/ssl/server_ext.cnf"
SERVER_CONF="/etc/ssl/server_cert.cnf"
SERVER_KEY="/etc/ssl/certs/lpic2.com.br-server-key.pem"
SERVER_CSR="/etc/ssl/certs/lpic2.com.br-server-req.pem"
SERVER_CRT="/etc/ssl/certs/lpic2.com.br-server-cert.pem"
CLIENT_EXT="/etc/ssl/client_ext.cnf"
CLIENT_CONF="/etc/ssl/client_cert.cnf"
CLIENT_KEY="/etc/ssl/certs/lpic2.com.br-client-key.pem"
CLIENT_CSR="/etc/ssl/certs/lpic2.com.br-client-req.pem"
CLIENT_CRT="/etc/ssl/certs/lpic2.com.br-client-cert.pem"
CLIENT_P12="/etc/ssl/certs/lpic2.com.br-client-cert.p12"

# Creating the Certificate Authority's Certificate and Keys

## Generate a private key for the CA:
rm /etc/ssl/certs/*.pem
cp -f configs/apache-ha/ca_cert.cnf $CA_EXTFILE
dos2unix $CA_EXTFILE
openssl genrsa -out $CA_KEY 4096 2>/dev/null
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $CA_KEY"

## Generate the X509 certificate for the CA:
openssl \
req \
-new \
-x509 \
-nodes \
-days 30 \
-passout pass:vagrant \
-config $CA_EXTFILE \
-key $CA_KEY \
-out $CA_CRT 2>/dev/null

[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $CA_CRT"
openssl  x509 -noout -text -in $CA_CRT >/dev/null 2>&1
[[ $? -ne 0 ]] && echo "ERROR: Failed to read $CA_CRT"

# Creating the Server's Certificate and Keys

## Generate the private key and certificate request:
cp -f configs/apache-ha/server_cert.cnf $SERVER_CONF
cp -f configs/apache-ha/server_ext.cnf $SERVER_EXT
dos2unix $SERVER_CONF
dos2unix $SERVER_EXT
openssl \
req \
-newkey rsa:4096 \
-nodes \
-days 30 \
-passout pass:vagrant \
-config $SERVER_CONF \
-keyout $SERVER_KEY \
-out $SERVER_CSR  2>/dev/null
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $SERVER_CSR"

## Generate the X509 certificate for the server:
openssl \
x509 \
-req \
-in $SERVER_CSR \
-CA $CA_CRT \
-CAkey $CA_KEY \
-out $SERVER_CRT \
-CAcreateserial \
-days 30 \
-sha512 \
-extfile $SERVER_EXT
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $SERVER_CRT"
openssl verify -CAfile $CA_CRT $SERVER_CRT >/dev/null 2>&1
[[ $? -ne 0 ]] && echo "ERROR: Failed to verify $SERVER_CRT against $CA_CRT"

# Creating the Client's Certificate and Keys

## Generate the private key and certificate request:
cp -f configs/apache-ha/client_cert.cnf $CLIENT_CONF
cp -f configs/apache-ha/server_ext.cnf $CLIENT_EXT
dos2unix $CLIENT_CONF
dos2unix $CLIENT_EXT
openssl \
req \
-newkey rsa:4096 \
-nodes \
-days 30 \
-passout pass:vagrant \
-config $CLIENT_CONF \
-keyout $CLIENT_KEY \
-out $CLIENT_CSR  2>/dev/null
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $SERVER_CSR"

## Generate the X509 certificate for the client:
openssl \
x509 \
-req \
-in $CLIENT_CSR \
-CA $CA_CRT \
-CAkey $CA_KEY \
-out $CLIENT_CRT \
-CAcreateserial \
-days 30 \
-sha512 \
-extfile $CLIENT_EXT
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $CLIENT_CRT"
openssl verify -CAfile $CA_CRT $CLIENT_CRT >/dev/null 2>&1
[[ $? -ne 0 ]] && echo "ERROR: Failed to verify $CLIENT_CRT against $CA_CRT"

## Generate the pkc12 certificate for the client:
openssl pkcs12 \
-export \
-inkey $CLIENT_KEY \
-in $CLIENT_CRT \
-out $CLIENT_P12 \
-passout pass:vagrant 

# Verifying the Certificates

## Verify the CA server certificate:
openssl verify -CAfile $CA_CRT $CA_CRT
#certtool -i < /etc/ssl/certs/lpic2.com.br-ca-cert.pem
#openssl x509 -noout -text -in $CA_CRT

## Verify the server certificate:
openssl verify -CAfile $CA_CRT $SERVER_CRT
#certtool -i < /etc/ssl/certs/lpic2.com.br-server-cert.pem
#openssl x509 -noout -text -in $SERVER_CRT

## Verify the client certificate:
openssl verify -CAfile $CA_CRT $CLIENT_CRT
#certtool -i < /etc/ssl/certs/lpic2.com.br-client-cert.pem
#openssl x509 -noout -text -in $CLIENT_CRT

## Copy certificates to clients
# cp -f  /etc/ssl/certs/lpic2.com.br-ca-cert.pem \
# /etc/ssl/certs/lpic2.com.br-server-cert.pem \
# /etc/ssl/certs/lpic2.com.br-client-cert.p12 \
# configs/commons/

#######----End Generate Certificates----######


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

