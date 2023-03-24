#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for set environment for labs
    Author: Marcos Silvestrini
    Date: 24/03/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# # Mount CIFS Share

# ## Share CIFS Server debian-server01
# mkdir -p /mnt/debian-server01
# chown -R vagrant /mnt/debian-server01
# umount /mnt/debian-server01
# mount -t cifs -o username=vagrant,password=vagrant //debian-server01/vagrant /mnt/debian-server01

# ## Share CIFS Server ol9-server01
# mkdir -p /mnt/ol9-server01
# chown -R vagrant /mnt/ol9-server01
# umount /mnt/ol9-server01
# mount -t cifs -o username=vagrant,password=vagrant //ol9-server01/vagrant /mnt/ol9-server01

# ## Share CIFS Desktop Windows silvestrini
# mkdir -p /mnt/windows-project
# chown -R vagrant /mnt/windows-project
# umount /mnt/windows-project
# mount -t cifs -o vers=2.0,username=vagrant,password=vagrant //silvestrini/Projetos /mnt/windows-project

# Mount CIFS Share in /etc/fstab
#-rw-r--r-- 1 root root 652 Mar 24 10:25 /etc/fstab

## Configure access for share
cp configs/samba/.samba-access .
dos2unix .samba-access
chown vagrant:vagrant .samba-access

## Configure fstab
VM=$(hostname)
cp /etc/fstab "configs/commons/fstab_${VM}_backup"
cp "configs/commons/fstab_${VM}" /etc/fstab
dos2unix /etc/fstab
chmod 644 /etc/fstab  

## Mount shares
mount /mnt/debian-server01
mount /mnt/ol9-server01
mount /mnt/windows-project