#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for Configure Network in Server
    Author: Marcos Silvestrini
    Date: 05/04/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Route 172.16.32.0/24 - 192.168.0.141
route add -net 192.168.0.0/24 gw 172.16.32.210

# Add default route for network 172.16.32.0/24
route add default gw 172.16.32.210