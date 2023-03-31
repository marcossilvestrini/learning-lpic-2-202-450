#!/bin/bash

<<'SCRIPT-FUNCTIONS'
    Requirements: none
    Description: Script for Install and Configure DHCP Client
    Author: Marcos Silvestrini
    Date: 29/03/2023
SCRIPT-FUNCTIONS

export LANG=C

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install DHCP Server
if [[ $DISTRO == *"Debian"* ]]; then
    apt-get install -y isc-dhcp-client
else
    dnf install -y dhcp-client
fi

# Configure DHCP Client

## Set default lease
# -rw-r--r-- 1 root root 1735 May 27  2021 /etc/dhcp/dhclient.conf
cp configs/dhcp/dhclient.conf /etc/dhcp
dos2unix /etc/dhcp/dhclient.conf
chmod 644 /etc/dhcp/dhclient.conf

## Down link
ip link set eth2 down

## Clear interface eth2 configuration
ip addr flush eth2

## Delete old leases
rm -f /var/lib/dhcp/*

## Release an IP address for the `eth2` interface
dhclient -r -v eth2

## Get an IP address for the `eth2` interface:
dhclient -v eth2
#dhclient -4 -d -v -cf /etc/dhcp/dhclient.conf eth2

# Restart services
#/etc/init.d/networking restart