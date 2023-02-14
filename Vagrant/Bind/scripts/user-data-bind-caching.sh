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

# Install packages
dnf install -y bash-completion
dnf install -y sshpass
dnf install -y vim
dnf install -y htop
dnf install -y lsof
dnf install -y tree
dnf install -y net-tools
dnf install -y traceroute
dnf install -y sysstat
dnf install -y bind
dnf install -y bind-utils
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

#Set GnuGP
echo vagrant | $(su -c "gpg -k" -s /bin/bash vagrant)

#Install X11 Server
dnf config-manager --set-enabled ol9_codeready_builder
dnf update -y
dnf install -y xorg-x11-server-Xorg.x86_64 xorg-x11-xauth.x86_64 \
    xorg-x11-server-utils.x86_64 xorg-x11-utils.x86_64

# Enable sadc collected system activity
cp -f configs/commons/sysstat /etc/default/
systemctl start sysstat sysstat-collect.timer sysstat-summary.timer
systemctl enable sysstat sysstat-collect.timer sysstat-summary.timer

# Configure BIND

## Stop service
systemctl stop named

##Config bind caching parameters
cp -f configs/bind-caching/named.conf /etc

## Start service
systemctl start named

## Reload named.conf
rndc reconfig

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
