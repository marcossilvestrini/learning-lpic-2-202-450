#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for Configure Network in Server
    Author: Marcos Silvestrini
    Date: 05/04/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Install packages

apt-get install -y ftp

# Route 172.16.32.0/24 - 192.168.0.141
route add -net 172.16.32.0/24 gw 192.168.0.141
