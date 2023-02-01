#!/bin/bash

cd /home/vagrant || exit

#Set password account
usermod --password $(echo vagrant | openssl passwd -1 -stdin) vagrant
usermod --password $(echo vagrant | openssl passwd -1 -stdin) root

#Set profile in /etc/profile
cp -f configs/profile-debian /etc/profile

#Set vim profile
cp -f configs/.vimrc .

# Set bash session
cp -f configs/.bashrc-debian ./.bashrc

# Set properties for user root
cp .bashrc .vimrc /root/

# Set Swap memory
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

# Install packages
apt-get update -y
apt-get install -y sshpass
apt-get install -y vim
apt-get install -y tree
apt-get install -y python3-pip
apt-get install -y python3-venv
apt-get install -y net-tools
apt-get install -y network-manager
apt-get install -y sysstat
apt-get install -y htop
apt-get install -y collectd
apt install -y bind9
apt install -u dnsutils

# Set ssh
cp -f configs/01-sshd-custom.conf /etc/ssh/sshd_config.d
systemctl restart sshd
cat security/id_ecdsa.pub >>.ssh/authorized_keys
echo vagrant | $(su -c "ssh-keygen -q -t ecdsa -b 521 -N '' -f .ssh/id_ecdsa <<<y >/dev/null 2>&1" -s /bin/bash vagrant)

#Set GnuGP
echo vagrant | $(su -c "gpg --batch --gen-key configs/gen-key-script" -s /bin/bash vagrant)
echo vagrant | $(su -c "gpg --export --armor vagrant > .gnupg/vagrant.pub.key" -s /bin/bash vagrant)

#Install X11 Server
apt-get install xserver-xorg -y
Xorg -configure
mv /root/xorg.conf.new /etc/X11/xorg.conf

#Enable sadc collected system activity
sed -i 's/false/true/g' /etc/default/sysstat
cp -f configs/cron.d-sysstat /etc/cron.d/sysstat
systemctl start sysstat
systemctl enable sysstat

#Set Networkmanager
#sed -i '/\[main\]/a dns=none' /etc/NetworkManager/NetworkManager.conf
cp -f configs/01-NetworkManager-custom.conf /etc/NetworkManager/conf.d/
systemctl restart NetworkManager

#Configure BIND

## Stop bind server
systemctl stop named

##Config Bind master
cp -f configs/named.conf.local /etc/bind/named.conf.local
#chown root:bind /etc/bind/named.conf.local
#chmod 644 /etc/bind/named.conf.local

## Apply changes
systemctl start named
rndc reconfig

#set prefered DNS servers
apt-get install -y resolvconf
systemctl enable resolvconf.service
systemctl start resolvconf.service
cp -f configs/head /etc/resolvconf/resolv.conf.d/
resolvconf --enable-updates
#sed -i 's/nameserver 10.0.2.3/nameserver 192.168.0.141/g' /etc/resolvconf/resolv.conf.d/original
resolvconf -u
