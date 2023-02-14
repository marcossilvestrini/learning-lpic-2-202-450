#!/bin/bash
<<'SCRIPT-FUNCTION'
    Description: Script for learnning about iostat command
    Author: Marcos Silvestrini
    Date: 12/05/2022
SCRIPT-FUNCTION

#Set localizations for prevent bugs in operations
LANG=C

# Set workdir
cd /home/vagrant || exit

#Variables
IP_MASTER="192.168.0.140"
IP_SLAVE="192.168.0.141"
IP_FORWARDING="192.168.0.142"
IP_CACHING="192.168.0.145"

# File for outputs testing
FILE_TEST=test/check-bind-stack.txt
LINE="\n------------------------------------------------------\n"

echo -e $LINE >$FILE_TEST
echo "Check Bind Stack for This Lab..." >>$FILE_TEST
DATE=$(date '+%Y-%m-%d %H:%M:%S')
echo -e "\nDate: $DATE" >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

# Check Bind Master
echo -e $LINE >>$FILE_TEST
echo "Check Bind Master..." >>$FILE_TEST

## Check version of bind
echo -e $LINE >>$FILE_TEST
echo -e "Check version of bind \n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_MASTER -l vagrant sudo dig @$IP_MASTER chaos version.bind txt | grep -ws "version.bind." | sed 1d >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check named.conf
echo -e $LINE >>$FILE_TEST
echo -e "Check in file /etc/named.conf...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_MASTER -l vagrant sudo cat /etc/named.conf | grep -ws "options {" -A 9 >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_MASTER -l vagrant sudo cat /etc/named.conf | grep -ws "zone "."" -A 14 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Get zones
echo -e $LINE >>$FILE_TEST
echo -e "Get zones in file /etc/named.conf...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_MASTER -l vagrant sudo cat /var/named/lpic2.zone |
    grep -ws "@                   IN      NS      ol9-bind-master.lpic2.com.br." -A 14 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check file zone
echo -e $LINE >>$FILE_TEST
echo -e "Validade file zone...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_MASTER -l vagrant sudo named-checkzone lpic2.com.br /var/named/lpic2.zone >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check type of records
echo -e $LINE >>$FILE_TEST
echo -e "Check type records...\n" >>$FILE_TEST
dig -4 @$IP_MASTER lpic2.com.br ANY | grep -ws "QUESTION SECTION" -A 1 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST
dig -4 @$IP_MASTER lpic2.com.br ANY | grep -ws "ANSWER SECTION" -A 6 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST
dig -4 @$IP_MASTER lpic2.com.br ANY | grep -ws "ADDITIONAL SECTION" -A 4 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

# Check Bind Slave

echo -e $LINE >>$FILE_TEST
echo "Check Bind Slave..." >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check version of bind
echo -e $LINE >>$FILE_TEST
echo -e "Check version of bind \n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_SLAVE -l vagrant sudo dig @$IP_SLAVE chaos version.bind txt | grep -ws "version.bind." | sed 1d >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check named.conf
echo -e $LINE >>$FILE_TEST
echo -e "Check file /etc/named.conf...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_SLAVE -l vagrant sudo cat /etc/bind/named.conf.local | grep -ws "lpic2.com.br" -A 14 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check file zone
echo "Check file zone..." >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_SLAVE -l vagrant sudo ls -lt /var/cache/bind/lpic2.zone >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_SLAVE -l vagrant sudo named-compilezone -f raw -F text -o /tmp/lpic2.txt lpic2.com.br /var/cache/bind/lpic2.zone
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_SLAVE -l vagrant sudo cat /tmp/lpic2.txt >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check type of records
echo -e $LINE >>$FILE_TEST
echo -e "Check type records...\n" >>$FILE_TEST
dig -4 @$IP_SLAVE lpic2.com.br ANY | grep -ws "ANSWER SECTION" -A 6 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check transference zones
echo -e $LINE >>$FILE_TEST
echo -e "Check transference zones...\n" >>$FILE_TEST
host mail.lpic2.com.br $IP_MASTER >/dev/null 2>&1
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_MASTER -l vagrant sudo cat /var/named/data/named.run | grep AXFR >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

# Check Bind Forwarding

echo -e $LINE >>$FILE_TEST
echo "Check Bind Forwarding..." >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check version of bind
echo -e $LINE >>$FILE_TEST
echo -e "Check version of bind \n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_FORWARDING -l vagrant sudo dig @$IP_FORWARDING chaos version.bind txt | grep -ws "version.bind." | sed 1d >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check named.conf
echo -e $LINE >>$FILE_TEST
echo -e "Check file /etc/named.conf...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_FORWARDING -l vagrant sudo cat /etc/bind/named.conf.local | grep -ws "lpic2.com.br" -A 14 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check type of records
echo -e $LINE >>$FILE_TEST
echo -e "Check type records...\n" >>$FILE_TEST
dig -4 @$IP_MASTER lpic2.com.br ANY | grep -ws "ANSWER SECTION" -A 6 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

# Check Bind Caching

echo -e $LINE >>$FILE_TEST
echo "Check Bind Caching..." >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check version of bind
echo -e $LINE >>$FILE_TEST
echo -e "Check version of bind \n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_CACHING -l vagrant sudo dig @$IP_CACHING chaos version.bind txt | grep -ws "version.bind." | sed 1d >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check named.conf
echo -e $LINE >>$FILE_TEST
echo -e "Check file /etc/named.conf...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_CACHING -l vagrant sudo cat /etc/named.conf | grep -ws "options {" -A 9 >>$FILE_TEST
sshpass -p 'vagrant' ssh -o StrictHostKeyChecking=no vagrant@$IP_CACHING -l vagrant sudo cat /etc/named.conf | grep -ws "zone "."" -A 3 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check type of records
echo -e $LINE >>$FILE_TEST
echo -e "Check type records...\n" >>$FILE_TEST
dig -4 @$IP_MASTER lpic2.com.br ANY | grep -ws "ANSWER SECTION" -A 6 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST
