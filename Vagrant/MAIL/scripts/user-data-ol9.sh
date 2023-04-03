#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for set environment for labs
    Author: Marcos Silvestrini
    Date: 20/02/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant
usermod --password $(echo vagrant | openssl passwd -1 -stdin) root

# Enable Epel repo
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y

# Install packages
dnf update -y
dnf install -y bash-completion
dnf install -y vim
dnf install -y dos2unix
dnf install -y sshpass
dnf install -y htop
dnf install -y lsof
dnf install -y tree
dnf install -y net-tools
dnf install -y traceroute
dnf install -y sysstat

# Set profile in /etc/profile
cp -f configs/commons/profile-ol9 /etc/profile
dos2unix /etc/profile

# Set vim profile
cp -f configs/commons/.vimrc .
dos2unix .vimrc
chown vagrant:vagrant .vimrc

# Set bash session
cp -f configs/commons/.bashrc-ol9 .bashrc
dos2unix .bashrc .vimrc
chown root:root .bashrc .vimrc

# Set properties for user root
cp -f .bashrc .vimrc /root/

# SSH,FIREWALLD AND SELINUX
rm /etc/ssh/sshd_config.d/90-vagrant.conf
cp -f configs/commons/01-sshd-custom.conf /etc/ssh/sshd_config.d
dos2unix /etc/ssh/sshd_config.d
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
dos2unix /etc/default/sysstat
systemctl start sysstat sysstat-collect.timer sysstat-summary.timer
systemctl enable sysstat sysstat-collect.timer sysstat-summary.timer

# Set Default DNS Server

## Copy host file
cp -f configs/commons/hosts /etc
dos2unix /etc/hosts

## Set Networkmanager
cp -f configs/commons/01-NetworkManager-custom.conf /etc/NetworkManager/conf.d/
dos2unix /etc/NetworkManager/conf.d/01-NetworkManager-custom.conf
systemctl reload NetworkManager

## Set resolv.conf file
rm /etc/resolv.conf
cp configs/commons/resolv.conf.manually-configured /etc
dos2unix  /etc/resolv.conf.manually-configured
ln -s /etc/resolv.conf.manually-configured /etc/resolv.conf
