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

# Install packages
apt-get update -y
apt-get upgrade -y
apt-get install -y sshpass
apt-get install -y vim
apt-get install -y dos2unix
apt-get install -y tree
apt-get install -y python3-pip
apt-get install -y python3-venv
apt-get install -y net-tools
apt-get install -y network-manager
apt-get install -y sysstat
apt-get install -y htop
apt-get install -y collectd
apt-get install -y bind9
apt-get install -y dnsutils
apt-get install -y xserver-xorg

# Set profile in /etc/profile
cp -f configs/commons/profile-debian /etc/profile
dos2unix /etc/profile

# Set vim profile
cp -f configs/commons/.vimrc .
dos2unix .vimrc

# Set bash session
cp -f configs/commons/.bashrc-debian .bashrc
dos2unix .bashrc

# Set properties for user root
cp .bashrc .vimrc /root


# Set Swap memory
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Set ssh
cp -f configs/commons/01-sshd-custom.conf /etc/ssh/sshd_config.d
systemctl restart sshd
cat security/id_ecdsa.pub >>.ssh/authorized_keys
echo vagrant | $(su -c "ssh-keygen -q -t ecdsa -b 521 -N '' -f .ssh/id_ecdsa <<<y >/dev/null 2>&1" -s /bin/bash vagrant)

# Set GnuGP
echo vagrant | $(su -c "gpg --batch --gen-key configs/gen-key-script" -s /bin/bash vagrant)
echo vagrant | $(su -c "gpg --export --armor vagrant > .gnupg/vagrant.pub.key" -s /bin/bash vagrant)

# Set X11 Server
Xorg -configure
mv /root/xorg.conf.new /etc/X11/xorg.conf

# Enable sadc collected system activity
sed -i 's/false/true/g' /etc/default/sysstat
cp -f configs/commons/cron.d-sysstat /etc/cron.d/sysstat
systemctl start sysstat
systemctl enable sysstat

# Configure BIND

## Config Bind master
cp -f configs/bind-slave/named.conf.local /etc/bind
cp -f configs/commons/named.conf.options /etc/bind
dos2unix /etc/bind/named.conf.local
dos2unix /etc/bind/named.conf.options

## Apply changes
systemctl restart named
systemctl enable named

## Reload named.conf
rndc reload

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
