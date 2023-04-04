#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for Configure Mail Client
    Author: Marcos Silvestrini
    Date: 04/04/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install packages
if [[ $DISTRO == *"Debian"* ]]; then
    apt install -y dovecot-imapd dovecot-pop3d
    apt install -y thunderbird
else
    dnf install -y dovcot
    dnf -y install thunderbird
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

# # Configure file /etc/dovecot/dovecot.conf
#-rw-r--r-- 1 root root 4401 Jul 31  2022 /etc/dovecot/dovecot.conf
cp /etc/dovecot/dovecot.conf configs/postfix/dovecot.conf_backup
cp configs/postfix/dovecot.conf /etc/dovecot
dos2unix /etc/dovecot/dovecot.conf
chmod 644 /etc/dovecot/dovecot.conf

# Configure file /etc/dovecot/conf.d/10-auth.conf
cp configs/postfix/10-auth.conf /etc/dovecot/conf.d
dos2unix /etc/dovecot/conf.d/10-auth.conf
chmod 644 /etc/dovecot/conf.d/10-auth.conf

# Configure file /etc/dovecot/conf.d/10-master.conf
cp configs/postfix/10-master.conf /etc/dovecot/conf.d
dos2unix /etc/dovecot/conf.d/10-master.conf
chmod 644 /etc/dovecot/conf.d/10-master.conf

# Restart dovecot service
systemctl restart dovecot
