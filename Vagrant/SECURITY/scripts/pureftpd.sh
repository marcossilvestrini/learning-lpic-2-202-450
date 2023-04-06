#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for Configure PureFTPd in Server
    Author: Marcos Silvestrini
    Date: 06/04/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

DISTRO=$(cat /etc/*release | grep -ws NAME=)

if [[ "$DISTRO" == *"Debian"* ]]; then    
    # Install package
    apt install -y pure-ftpd
    # Create ftp user
    useradd -m ftp

else    
    dnf install -y pure-ftpd
fi

# Set file /etc/vsftpd.conf
#-rw-r--r-- 1 root root 5850 Aug  6  2019 /etc/pure-ftpd/pure-ftpd.conf
cp configs/pure-ftpd/pure-ftpd.conf /etc/pure-ftpd
dos2unix /etc/pure-ftpd/pure-ftpd.conf
chmod 644 /etc/pure-ftpd/pure-ftpd.conf

# Set NoAnonymous login
cp configs/pure-ftpd/NoAnonymous /etc/pure-ftpd/conf
dos2unix /etc/pure-ftpd/conf/NoAnonymous

# Set chroo directory
cp configs/pure-ftpd/ChrootEveryone /etc/pure-ftpd/conf
dos2unix /etc/pure-ftpd/conf/ChrootEveryone

# Restart service
systemctl restart pure-ftpd
