#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for Configure Server
    Author: Marcos Silvestrini
    Date: 05/04/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Install packages
apt install -y fail2ban
apt install -y openvpn

# Enable packet forwarding for IPv4
# -rw-r--r-- 1 root root 2355 Apr  6  2021 /etc/sysctl.conf
cp  configs/commons/sysctl.conf /etc
dos2unix /etc/sysctl.conf
chmod 644 /etc/sysctl.conf
sysctl -p

############## TABLE FILTER ################
# # Create rule for allow loopback interface
# iptables -t filter -A INPUT -i lo -j ACCEPT
# iptables -t filter -A OUTPUT -o lo -j ACCEPT
# iptables -t filter -A FORWARD -i lo -j ACCEPT

# # Create rule for allow ssh connections
# iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
# iptables -t filter -A INPUT -p tcp --dport 2222 -j ACCEPT
# iptables -t filter -A FORWARD -p tcp --dport 22 -j ACCEPT
# iptables -t filter -A FORWARD -p tcp --sport 22 -j ACCEPT
# iptables -t filter -A OUTPUT -p tcp --sport 22 -j ACCEPT
# iptables -t filter -A OUTPUT -p tcp --sport 2222 -j ACCEPT

# # Create rule for DROP all others connections
# iptables -t filter -P INPUT DROP
# iptables -t filter -P FORWARD DROP
# iptables -t filter -P OUTPUT DROP
############## TABLE FILTER ################


############## TABLE NAT    ################
#EXTERNAL_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
#iptables -t nat -A POSTROUTING -s 172.16.32.0/24 -o eth2 -j SNAT --to-source $EXTERNAL_IP
#iptables -t nat -A POSTROUTING -s 172.16.32.0/24 -o eth2 -j SNAT --to-source 192.168.0.141
############## TABLE NAT    ################


