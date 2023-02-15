#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for set environment for labs
    Author: Marcos Silvestrini
    Date: 14/02/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant
usermod --password $(echo vagrant | openssl passwd -1 -stdin) root

# Set profile in /etc/profile
cp -f configs/commons/profile /etc

# Set vim profile
cp -f configs/commons/.vimrc .

# Set bash session
cp -f configs/commons/.bashrc .

# Set properties for user root
cp .bashrc .vimrc /root/

# Enable Epel repo
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
#dnf -y upgrade

# Install packages
dnf install -y bash-completion
dnf install -y vim
dnf install -y sshpass
dnf install -y htop
dnf install -y lsof
dnf install -y tree
dnf install -y net-tools
dnf install -y traceroute
dnf install -y sysstat
dnf install -y bind
dnf install -y bind-utils
dnf install -y whois
dnf install -y bind-dnssec-utils

# SSH,FIREWALLD AND SELINUX
#sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
rm /etc/ssh/sshd_config.d/90-vagrant.conf
cp -f configs/commons/01-sshd-custom.conf /etc/ssh/sshd_config.d
systemctl restart sshd
cat security/id_ecdsa.pub >>.ssh/authorized_keys
echo vagrant | $(su -c "ssh-keygen -q -t ecdsa -b 521 -N '' -f .ssh/id_ecdsa <<<y >/dev/null 2>&1" -s /bin/bash vagrant)
systemctl restart sshd
systemctl stop firewalld
systemctl disable firewalld
setenforce Permissive

# Set GnuGP
echo vagrant | $(su -c "gpg -k" -s /bin/bash vagrant)

# Install X11 Server
dnf config-manager --set-enabled ol9_codeready_builder
dnf update -y
dnf install -y xorg-x11-server-Xorg.x86_64 xorg-x11-xauth.x86_64 \
    xorg-x11-server-utils.x86_64 xorg-x11-utils.x86_64

# Enable sadc collected system activity
cp -f configs/commons/sysstat /etc/default/
systemctl start sysstat sysstat-collect.timer sysstat-summary.timer
systemctl enable sysstat sysstat-collect.timer sysstat-summary.timer

# Configure BIND

## Stop bind server
systemctl stop named

## Config Bind master
cp -f configs/bind-master/named.conf /etc

## Set zone file with type records (SOA,NS,MX,A,TXT,etc)
cp -f configs/bind-master/lpic2.zone /var/named
chmod 640 /var/named/lpic2.zone
chown root:named /var/named/lpic2.zone

## Set reverse zone file with type record (PTR)
cp -f configs/bind-master/0.168.192.in-addr.arpa.zone /var/named
chmod 640 /var/named/0.168.192.in-addr.arpa.zone
chown root:named /var/named/0.168.192.in-addr.arpa.zone

## Validate zone file
named-checkzone lpic2.com.br /var/named/lpic2.zone

## Start service
systemctl start named
systemctl enable named

## Reload named.conf
rndc reconfig

## Sign DNSSEC key
cp configs/bind-master/Klpic2.com.br.+013+29838.* /var/named
dnssec-signzone -P -o lpic2.com.br /var/named/lpic2.zone /var/named/Klpic2.com.br.+013+29838.private

# Set Default DNS Server

## Copy host file
cp -f configs/commons/hosts /etc

## Set Networkmanager
cp -f configs/commons/01-NetworkManager-custom.conf /etc/NetworkManager/conf.d/
systemctl reload NetworkManager

## Set resolv.conf file
rm /etc/resolv.conf
cp configs/commons/resolv.conf.manually-configured /etc
ln -s /etc/resolv.conf.manually-configured /etc/resolv.conf
