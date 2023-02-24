#!/bin/bash
<<'SCRIPT-FUNCTION'
    Description: Script for check HTTP Stack
    Author: Marcos Silvestrini
    Date: 23/02/2023
SCRIPT-FUNCTION

#Set localizations for prevent bugs in operations
LANG=C

# Set workdir
cd /home/vagrant || exit

#Variables
IP_HA="192.168.0.142"
IP_NODE01="192.168.0.143"

# File for outputs testing
FILE_TEST=test/check-http-stack.txt
LINE="------------------------------------------------------"

echo $LINE >$FILE_TEST
echo "Check HTTP Stack for This Lab" >>$FILE_TEST
DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo "Date: $DATE" >>$FILE_TEST
echo -e "$LINE\n" >>$FILE_TEST

# Check Apache HA
echo $LINE >>$FILE_TEST
echo "Check Apache HA..." >>$FILE_TEST
echo -e "$LINE\n" >>$FILE_TEST

## Check status
echo -e "Check Status of Apache HA...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_HA -l vagrant \
    sudo apachectl status | grep "Active" >>$FILE_TEST
echo $LINE >>$FILE_TEST

## Check version of apache
echo -e "Check version of Apache HA...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_HA -l vagrant \
    sudo httpd -v >>$FILE_TEST
echo $LINE >>$FILE_TEST

#check status code apache
#curl -LI http://skynet.lpic2.com.br -o /dev/null -w '%{http_code}\n' -s

#test php
#curl -LI http://skynet.lpic2.com.br/info.php -o /dev/null -w '%{http_code}\n' -s

# Check Apache  NODE01
echo $LINE >>$FILE_TEST
echo "Check Apache NODE01..." >>$FILE_TEST
echo -e "$LINE\n" >>$FILE_TEST

## Check status
echo -e "Check version of Apache NODE01...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_NODE01 -l vagrant \
    sudo systemctl status apache2 | grep "Active" >>$FILE_TEST
echo $LINE >>$FILE_TEST

## Check version of apache
echo -e "Check version of Apache NODE01...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_NODE01 -l vagrant \
    sudo apache2 -v >>$FILE_TEST
echo $LINE >>$FILE_TEST
