#!/bin/bash

<<'SCRIPT-FUNCTIONS'
    Requirements: none
    Description: Script for Install and Configure OpenLDAP Client and Utilities
    Author: Marcos Silvestrini
    Date: 30/03/2023
SCRIPT-FUNCTIONS

export LANG=C

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install DHCP Server
if [[ $DISTRO == *"Debian"* ]]; then
    apt-get install -y jxplorer
    apt-get install -y ldap-utils
    
else
    dnf install -y jxplorer
fi
