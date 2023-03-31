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

# Configure OpenLDAP Server - (Method use actual by OpenLDAP - slapd.d)

## Check configuration
slaptest

## Modify OpenLDAP database for my custom dc
ldapmodify -Y EXTERNAL -H ldapi:/// -f configs/ldap/db.ldif

## Import defaults schemas
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/nis.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/ldap/schema/inetorgperson.ldif

## Create LDAP databases(.ldif)
ldapadd -a -x -w vagrant -D "cn=admin,dc=lpic2,dc=com,dc=br" -f configs/ldap/lpic2.ldif

## Restart OpenLDAP Server
#rm -f /var/lib/ldap/*
systemctl restart slapd
