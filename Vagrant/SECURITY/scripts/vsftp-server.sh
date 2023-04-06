#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for Configure VSFTP in Server
    Author: Marcos Silvestrini
    Date: 06/04/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

DISTRO=$(cat /etc/*release | grep -ws NAME=)

if [[ "$DISTRO" == *"Debian"* ]]; then    
    apt install -y vsftpd
else    
    dnf install -y vsftpd
fi

# Set file /etc/vsftpd.conf
#-rw-r--r-- 1 root root 5850 Aug  6  2019 /etc/vsftpd.conf
mkdir -p /var/ftp/pub
chown ftp:ftp /var/ftp/pub
cp configs/vsftpd/vsftpd.conf /etc
dos2unix /etc/vsftpd.conf
chmod 644 /etc/vsftpd.conf


# Restart service
systemctl restart vsftpd
