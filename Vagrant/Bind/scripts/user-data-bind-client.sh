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
dnf install -y sshpass
dnf install -y net-tools
dnf install -y bind-utils

# SSH,FIREWALLD AND SELINUX
#sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
rm /etc/ssh/sshd_config.d/90-vagrant.conf
cp -f configs/01-sshd-custom.conf /etc/ssh/sshd_config.d
systemctl restart sshd
cat security/id_ecdsa.pub >>.ssh/authorized_keys
echo vagrant | $(su -c "ssh-keygen -q -t ecdsa -b 521 -N '' -f .ssh/id_ecdsa <<<y >/dev/null 2>&1" -s /bin/bash vagrant)
systemctl restart sshd
systemctl stop firewalld
systemctl disable firewalld
setenforce Permissive

#Set GnuGP
echo vagrant | $(su -c "gpg -k" -s /bin/bash vagrant)

## Set Networkmanager
cp -f configs/01-NetworkManager-custom.conf /etc/NetworkManager/conf.d/
systemctl reload NetworkManager

## Set resolv.conf file
rm /etc/resolv.conf
cp configs/resolv.conf.manually-configured /etc
ln -s /etc/resolv.conf.manually-configured /etc/resolv.conf
