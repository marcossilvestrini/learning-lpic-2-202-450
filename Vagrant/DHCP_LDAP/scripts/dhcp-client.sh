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

## Clear interface eth2 configuration
ip addr flush eth2

## Release an IP address for the `eth2` interface
# dhclient -r eth2

## Get an IP address for the `eth2` interface:
dhclient eth2