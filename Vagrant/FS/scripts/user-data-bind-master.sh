#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for Configure Bind Master
    Author: Marcos Silvestrini
    Date: 24/03/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Install packages
dnf install -y bind
dnf install -y bind-utils
dnf install -y whois
dnf install -y bind-dnssec-utils
dnf install -y bind-chroot

# Configure BIND

## Stop bind
systemctl stop named

## Config Bind master
#-rw-r-----. 1 root named 1722 Nov 16 08:44 /etc/named.conf
cp -f configs/bind-master/named.conf /etc
dos2unix /etc/named.conf
chown root:named /etc/named.conf
chmod 640 /etc/named.conf

## Set zone file with type records (SOA,NS,MX,A,TXT,etc)
cp -f configs/bind-master/lpic2.zone /var/named
dos2unix /var/named/lpic2.zone
chown root:named /var/named/lpic2.zone
chmod 640 /var/named/lpic2.zone

## Set reverse zone file with type record (PTR)
cp -f configs/bind-master/0.168.192.in-addr.arpa.zone /var/named
dos2unix /var/named/0.168.192.in-addr.arpa.zone
chown root:named /var/named/0.168.192.in-addr.arpa.zone
chmod 640 /var/named/0.168.192.in-addr.arpa.zone

## Sign DNSSEC key
cp configs/bind-master/Klpic2.com.br.+013+29838.* /var/named
dnssec-signzone -P -o lpic2.com.br /var/named/lpic2.zone /var/named/Klpic2.com.br.+013+29838.private

## chroot jail (Running BIND9 in a chroot cage)
/usr/libexec/setup-named-chroot.sh /var/named/chroot on

## Start service
systemctl start named-chroot
systemctl enable named-chroot

## Validate zone file
named-checkzone lpic2.com.br /var/named/lpic2.zone

## Reload named.conf
rndc reconfig
rndc reload
