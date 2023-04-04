#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for Configure Postfix Mail Server
    Author: Marcos Silvestrini
    Date: 03/04/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install packages
if [[ $DISTRO == *"Debian"* ]]; then
    apt install -y postfix
else
    ## Install Postfix server
    dnf install -y postfix
    ## Install MTA - Sieve suported - davecot
    dnf install -y dovecot-pigeonhole

fi

# Create user silvestrini for test mail
userdel -fr silvestrini
rm -rf /home/silvestrini
useradd -m silvestrini
usermod --password $(echo silvestrini | openssl passwd -1 -stdin) silvestrini
chown -R silvestrini:silvestrini /home/silvestrini

# Create user skynet for test mail
userdel -fr skynet
rm -rf /home/skynet
useradd -m skynet
usermod --password $(echo skynet | openssl passwd -1 -stdin) skynet
chown -R skynet:skynet /home/skynet

# Configure Postfix

## Clear all messages 
rm -rf /var/mail/*

## Set file /etc/postfix/main.cf
#-rw-r--r--. 1 root root 29369 Oct  3 05:27 /etc/postfix/main.cf 
cp /etc/postfix/main.cf configs/postfix/main.cf_backup
cp configs/postfix/main.cf /etc/postfix
dos2unix /etc/postfix/main.cf
chmod 644 /etc/postfix/main.cf

## Configure Cononical Maps
cp configs/postfix/sender_canonical /etc/postfix
dos2unix /etc/postfix/sender_canonical
chmod 644 /etc/postfix/sender_canonical
postmap /etc/postfix/sender_canonical

## Configure aliases
# -rw-r--r--. 1 root root 1529 Jun 23  2020 /etc/aliases
cp /etc/aliases configs/postfix/aliases_backup
cp configs/postfix/aliases /etc/aliases
dos2unix /etc/aliases
chmod 644 /etc/aliases
newaliases

## Configure MTA - Dovicot

## Generate ssl certificates
rm -f /etc/pki/dovecot/private/dovecot.pem
rm -f /etc/pki/dovecot/certs/dovecot.pem

if [[ $DISTRO == *"Debian"* ]]; then
    . /usr/share/dovecot/mkcert.sh
else
    cp configs/postfix/dovecot-openssl.cnf /etc/pki/dovecot
    dos2unix /etc/pki/dovecot/dovecot-openssl.cnf
    chmod 644 /etc/pki/dovecot/dovecot-openssl.cnf
    . /usr/libexec/dovecot/mkcert.sh >/dev/null 2>&1
fi

### Configure file /etc/dovecot/dovecot.conf
#-rw-r--r-- 1 root root 4401 Jul 31  2022 /etc/dovecot/dovecot.conf
cp /etc/dovecot/dovecot.conf configs/postfix/dovecot.conf_backup
cp configs/postfix/dovecot.conf /etc/dovecot
dos2unix /etc/dovecot/dovecot.conf
chmod 644 /etc/dovecot/dovecot.conf

### Set access to dovecot
chgrp mail /usr/libexec/dovecot/dovecot-lda
chmod 2755 /usr/libexec/dovecot/dovecot-lda

### Set conf.d files
cp configs/postfix/10-mail.conf  /etc/dovecot/conf.d/
cp configs/postfix/15-lda.conf  /etc/dovecot/conf.d/
cp configs/postfix/90-sieve.conf  /etc/dovecot/conf.d/
cp configs/postfix/10-ssl.conf  /etc/dovecot/conf.d/
cp configs/postfix/10-auth.conf /etc/dovecot/conf.d
cp configs/postfix/10-master.conf /etc/dovecot/conf.d
dos2unix /etc/dovecot/conf.d/10-mail.conf
dos2unix /etc/dovecot/conf.d/15-lda.conf
dos2unix /etc/dovecot/conf.d/90-sieve.conf
dos2unix /etc/dovecot/conf.d/10-ssl.conf
dos2unix /etc/dovecot/conf.d/10-auth.conf
dos2unix /etc/dovecot/conf.d/10-master.conf


### Set rules for user vagrant
rm -rf mail
cp configs/postfix/.dovecot.sieve .
dos2unix .dovecot.sieve
chown vagrant:vagrant .dovecot.sieve

### Set rules for user silvestrini
rm -rf /home/silvestrini/mail
cp configs/postfix/.dovecot.sieve /home/silvestrini
dos2unix /home/silvestrini/.dovecot.sieve
chown silvestrini:silvestrini /home/silvestrini/.dovecot.sieve


### Set rules for user skynet
rm -rf /home/skynet/mail
cp configs/postfix/.dovecot.sieve /home/skynet
dos2unix /home/skynet/.dovecot.sieve
chown skynet:skynet /home/skynet/.dovecot.sieve


### Restart dovecot service
systemctl restart dovecot

## Reload configuration
postfix reload

## Restart Postfix services
systemctl restart postfix

