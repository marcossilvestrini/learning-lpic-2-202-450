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
dnf install -y bind
dnf install -y bind-utils
dnf install -y whois
dnf install -y bind-dnssec-utils
dnf install -y bind-chroot

# Set profile in /etc/profile
cp -f configs/commons/profile-ol9 /etc/profile
dos2unix /etc/profile

# Set vim profile
cp -f configs/commons/.vimrc .
dos2unix .vimrc

# Set bash session
cp -f configs/commons/.bashrc-ol9 .bashrc
dos2unix .bashrc

# Set properties for user root
cp .bashrc .vimrc /root/

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

## Stop bind
systemctl stop named

## Config Bind master
#-rw-r-----. 1 root named 1722 Nov 16 08:44 /etc/named.conf
cp -f configs/bind-master/named.conf /etc
dos2unix /etc/named.conf
chown root:named /etc/named.conf
chmod 640 /etc/named.conf

## Set zone file with type records (SOA,NS,MX,A,TXT,etc)
cp -f configs/bind-master/lpic2.zone /var/named
dos2unix /var/named/lpic2.zone
chown root:named /var/named/lpic2.zone
chmod 640 /var/named/lpic2.zone

## Set reverse zone file with type record (PTR)
cp -f configs/bind-master/0.168.192.in-addr.arpa.zone /var/named
dos2unix /var/named/0.168.192.in-addr.arpa.zone
chown root:named /var/named/0.168.192.in-addr.arpa.zone
chmod 640 /var/named/0.168.192.in-addr.arpa.zone

## Sign DNSSEC key
cp configs/bind-master/Klpic2.com.br.+013+29838.* /var/named
dnssec-signzone -P -o lpic2.com.br /var/named/lpic2.zone /var/named/Klpic2.com.br.+013+29838.private

## chroot jail (Running BIND9 in a chroot cage)
/usr/libexec/setup-named-chroot.sh /var/named/chroot on

## Start service
systemctl start named-chroot
systemctl enable named-chroot

## Validate zone file
named-checkzone lpic2.com.br /var/named/lpic2.zone

## Reload named.conf
rndc reconfig
rndc reload

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
