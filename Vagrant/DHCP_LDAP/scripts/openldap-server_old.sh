#!/bin/bash

<<'SCRIPT-FUNCTIONS'
    Requirements: none
    Description: Script for Install and Configure OpenLDAP Server
    Author: Marcos Silvestrini
    Date: 30/03/2023
SCRIPT-FUNCTIONS

export LANG=C

# Variables
DISTRO=$(cat /etc/*release | grep -ws NAME=)

# Install OpenLDAP Server
if [[ $DISTRO == *"Debian"* ]]; then  
  echo 'slapd/root_password password vagrant' | debconf-set-selections \
  && echo 'slapd/root_password_again password vagrant' | debconf-set-selections \
  && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
  apt-get install -y slapd ldap-utils  
else
  echo "DISTRO NOTE SUPORTED BY THIS SCRIPT!!!!"
  exit 1
fi

# Configure OpenLDAP Server (old method with /etc/ldap/slapd.conf - discontinued)

## Stop services
systemctl stop slapd

## Set /etc/default/slapd
# -rw-r--r-- 1 root root 1770 May 15  2021 /etc/default/slapd
cp /etc/default/slapd configs/ldap/slapd_backup
cp configs/ldap/slapd_with_slapd_conf /etc/default/slapd
dos2unix /etc/default/slapd
chmod 644 /etc/default/slapd

## Set /etc/slapd/slapd.conf
cp configs/ldap/slapd.conf /etc/ldap
dos2unix /etc/ldap/slapd.conf
chmod 644 /etc/ldap/slapd.conf

## Check configuration
slaptest -f /etc/ldap/slapd.conf

## Create LDAP databases(.ldif)
ldapadd -a -x -w vagrant -D "cn=admin,dc=lpic2,dc=com,dc=br" -f configs/ldap/lpic2.ldif
ldapadd -a -x -w vagrant -D "cn=admin,dc=empresa,dc=com" -f configs/ldap/empresa.ldif

## Reindex entries in a SLAPD database
slapindex -f /etc/ldap/slapd.conf

## Restart OpenLDAP Server
#rm -f /var/lib/ldap/*
systemctl restart slapd
