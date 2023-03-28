#!/bin/bash

<<'SCRIPT-FUNCTIONS'
    Requirements: none
    Description: Script for Install and Configure NFS Server
    Author: Marcos Silvestrini
    Date: 27/03/2023
SCRIPT-FUNCTIONS

export LANG=C

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install Samba Server and Client
if [[ $DISTRO == *"Debian"* ]]; then
    apt-get install -y rpcbind nfs-common nfs-kernel-server
else
    dnf install -y nfs-utils rpcbind
fi

# Configure NFS

## Configure NFS defaults(disable NFS Version 4)
#-rw-r--r-- 1 root root 632 Jun 28  2021 /etc/default/nfs-kernel-server
cp /etc/default/nfs-kernel-server configs/nfs/nfs-kernel-server_backup
cp configs/nfs/nfs-kernel-server /etc/default
dos2unix /etc/default/nfs-kernel-server
chmod 644 /etc/default/nfs-kernel-server

## Configure Mount Points
#-rw-r--r-- 1 root root 389 Jun 28  2021 /etc/exports
cp -p /etc/exports configs/nfs/exports_backup
cp configs/nfs/exports /etc
dos2unix /etc/exports
chmod 644 /etc/exports
exportfs -a

# Reload Daemon Server
systemctl daemon-reload

# Restart NFS
systemctl restart rpcbind
systemctl restart nfs-server.service
systemctl restart nfs-kernel-server

