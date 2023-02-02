#!/bin/bash

cd /home/vagrant || exit

# Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant
usermod --password $(echo vagrant | openssl passwd -1 -stdin) root

# Set profile in /etc/profile
cp -f configs/profile /etc

# Set vim profile
cp -f configs/.vimrc .

# Set bash session
rm .bashrc
cp -f configs/.bashrc .

# Set properties for user root
cp .bashrc .vimrc /root/

# Enable Epel repo
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
#dnf -y upgrade

# Install packages
dnf install -y bash-completion
dnf install -y vim
dnf install -y htop
dnf install -y lsof
dnf install -y tree
dnf install -y net-tools
dnf install -y traceroute
dnf install -y sysstat
dnf install -y bind
dnf install -y bind-utils
dnf install -y whois

# SSH,FIREWALLD AND SELINUX
sed -i 's/#PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
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
cp -f configs/sysstat /etc/default/
systemctl start sysstat sysstat-collect.timer sysstat-summary.timer
systemctl enable sysstat sysstat-collect.timer sysstat-summary.timer

# Configure BIND

## Stop bind server
systemctl stop named

## Config Bind master
cp -f configs/named.conf-master /etc/named.conf

## Set zone file with type records (SOA,NS,MX,A,TXT,etc)
cp -f configs/lpic2.zone /var/named/lpic2.zone
chmod 640 /var/named/lpic2.zone
chown root:named /var/named/lpic2.zone

## Validate zone file
named-checkzone lpic2.com.br /var/named/lpic2.zone

## Start service
systemctl start named
rndc reconfig

# Set Default DNS Server

## Set Networkmanager
cp -f configs/01-NetworkManager-custom.conf /etc/NetworkManager/conf.d/
systemctl reload NetworkManager

## Set resolv.conf file
rm /etc/resolv.conf
cp configs/resolv.conf.manually-configured /etc
ln -s /etc/resolv.conf.manually-configured /etc/resolv.conf
