#!/bin/bash

<<'SCRIPT-FUNCTIONS'
    Requirements: none
    Description: Script for Install and Configure DHCP Server
    Author: Marcos Silvestrini
    Date: 28/03/2023
SCRIPT-FUNCTIONS

export LANG=C

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install DHCP Server
if [[ $DISTRO == *"Debian"* ]]; then
    apt-get install -y isc-dhcp-server
else
    dnf install -y dhcp
fi

# Configure DHCP Server

## Configure file /etc/default/isc-dhcp-server (INTERFACEv4)
# -rw-r--r-- 1 root root 625 Mar 28 17:33 /etc/default/isc-dhcp-server
cp /etc/default/isc-dhcp-server configs/dhcp/isc-dhcp-server_backup
cp configs/dhcp/isc-dhcp-server /etc/default/
dos2unix /etc/default/isc-dhcp-server
chmod 644 /etc/default/isc-dhcp-server

## Configure file /etc/dhcp/dhcpd.conf
# -rw-r--r-- 1 root root 3496 Oct  4 17:52 /etc/dhcp/dhcpd.conf
cp /etc/dhcp/dhcpd.conf configs/dhcp/dhcpd.conf_backup
cp configs/dhcp/dhcpd.conf /etc/dhcp
dos2unix /etc/dhcp/dhcpd.conf
chmod 644 /etc/dhcp/dhcpd.conf

## Restart DHCP server
systemctl restart isc-dhcp-server