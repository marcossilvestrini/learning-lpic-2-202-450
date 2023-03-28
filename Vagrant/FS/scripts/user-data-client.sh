#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for set environment for labs
    Author: Marcos Silvestrini
    Date: 24/03/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install Samba Server and Client
if [[ $DISTRO == *"Debian"* ]]; then
    apt-get install -y nfs-common
else
    dnf install -y nfs-utils
fi

# Mount Share in /etc/fstab
#-rw-r--r-- 1 root root 652 Mar 24 10:25 /etc/fstab

## Configure access for share
cp configs/samba/.samba-access .
dos2unix .samba-access
chown vagrant:vagrant .samba-access

## Configure fstab
VM=$(hostname)
cp /etc/fstab "configs/commons/fstab_${VM}_backup"
cp "configs/commons/fstab_${VM}" /etc/fstab
dos2unix /etc/fstab
chmod 644 /etc/fstab  

## Mount CIFS shares
mkdir -p {/mnt/samba-debian-server01,/mnt/samba-ol9-server01,/mnt/samba-windows-project} 
mount /mnt/samba-debian-server01
mount /mnt/samba-ol9-server01
mount /mnt/samba-windows-project

## Mount NFS shares
mkdir -p {/mnt/nfs-debian-server01-home,/mnt/nfs-debian-server01-logs,/mnt/nfs-debian-server01-etc}
mount /mnt/nfs-debian-server01-home
mount /mnt/nfs-debian-server01-logs
mount /mnt/nfs-debian-server01-etc