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

# File for outputs testing
FILE_TEST=test/check-bind-stack.txt
LINE="\n------------------------------------------------------\n"

echo -e $LINE >$FILE_TEST
echo "Check Bind Stack for This Lab..." >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

# Check Bind Master
echo -e $LINE >>$FILE_TEST
echo "Check Bind Master..." >>$FILE_TEST

## Check named.conf
echo -e $LINE >>$FILE_TEST
echo -e "Check file /etc/named'.conf...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh vagrant@192.168.0.140 -l vagrant sudo cat /var/named/lpic2.zone |
    grep -ws "@                   IN      NS      ol9-bind-master.lpic2.com.br." -A 14 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check file zone
echo -e $LINE >>$FILE_TEST
echo -e "Check file zone...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh vagrant@192.168.0.140 -l vagrant sudo named-checkzone lpic2.com.br /var/named/lpic2.zone >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check type of records
echo -e $LINE >>$FILE_TEST
echo -e "Check type records...\n" >>$FILE_TEST

dig -4 @192.168.0.140 lpic2.com.br ANY | grep -ws "QUESTION SECTION" -A 1 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

dig -4 @192.168.0.140 lpic2.com.br ANY | grep -ws "ANSWER SECTION" -A 6 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

dig -4 @192.168.0.140 lpic2.com.br ANY | grep -ws "ADDITIONAL SECTION" -A 4 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

# Check Bind Slave

echo -e $LINE >>$FILE_TEST
echo "Check Bind Slave..." >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check named.conf
echo -e $LINE >>$FILE_TEST
echo -e "Check file /etc/named'.conf...\n" >>$FILE_TEST
sshpass -p 'vagrant' ssh vagrant@192.168.0.141 -l vagrant sudo cat /etc/bind/named.conf.local | grep -ws "lpic2.com.br" -A 14 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check file zone
echo "Check file zone..." >>$FILE_TEST
sshpass -p 'vagrant' ssh vagrant@192.168.0.141 -l vagrant sudo ls -lt /var/cache/bind/lpic2.zone >>$FILE_TEST
sshpass -p 'vagrant' ssh vagrant@192.168.0.141 -l vagrant sudo named-compilezone -f raw -F text -o /tmp/lpic2.txt lpic2.com.br /var/cache/bind/lpic2.zone
sshpass -p 'vagrant' ssh vagrant@192.168.0.141 -l vagrant sudo cat /tmp/lpic2.txt >>$FILE_TEST

echo -e $LINE >>$FILE_TEST

## Check type of records
echo -e $LINE >>$FILE_TEST
echo -e "Check type records...\n" >>$FILE_TEST
dig -4 @192.168.0.141 lpic2.com.br ANY | grep -ws "ANSWER SECTION" -A 6 >>$FILE_TEST
echo -e $LINE >>$FILE_TEST

## Check transference zones
echo -e $LINE >>$FILE_TEST
echo -e "Check transference zones...\n" >>$FILE_TEST
host mail.lpic2.com.br 192.168.0.140
sshpass -p 'vagrant' ssh vagrant@192.168.0.140 -l vagrant cat /var/named/data/named.run | grep AXFR >>$FILE_TEST
echo -e $LINE >>$FILE_TEST
