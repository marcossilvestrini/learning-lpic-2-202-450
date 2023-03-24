#!/bin/bash

<<'SCRIPT-FUNCTIONS'
    Requirements: none
    Description: Script for Install and Configure Samba Server
    Author: Marcos Silvestrini
    Date: 24/03/2023
SCRIPT-FUNCTIONS

export LANG=C

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install Samba Server and Client
if [[ $DISTRO == *"Debian"* ]]; then
    apt install -y samba samba-client
else
    dnf install -y samba samba-client
fi

# Configure Samba
#-rw-r--r-- 1 root root 8637 Mar 24 10:33 /etc/samba/smb.conf
cp -p /etc/samba/smb.conf configs/samba/smb.conf_backup
cp configs/samba/smb.conf /etc/samba/
dos2unix /etc/samba/smb.conf
chmod 644 /etc/samba/smb.conf

# Create user for samba shared
yes vagrant|head -n 2|smbpasswd -a -s vagrant
cp configs/samba/username.map /etc/samba
dos2unix /etc/samba/username.map

# Reload Daemon Server
systemctl daemon-reload

# Restart Samba
if [[ $DISTRO == *"Debian"* ]]; then    
    systemctl restart smbd
    systemctl restart nmbd
else
    systemctl restart smb
    systemctl restart nmb
fi
