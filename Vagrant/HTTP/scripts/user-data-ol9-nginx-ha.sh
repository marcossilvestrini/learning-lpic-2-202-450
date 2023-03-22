#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for configure NGINX
    Author: Marcos Silvestrini
    Date: 22/02/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Install nGINX
dnf install -y nginx
dnf install -y php php-fpm


# Tunning Nginx

## Configure /etc/nginx/nginx.conf
#-rw-r--r--. 1 root root 2334 Oct  6 18:24 /etc/nginx/nginx.conf
cp -p /etc/nginx/nginx.conf configs/nginx-ha/nginx.conf_backup
cp -f configs/nginx-ha/nginx.conf /etc/nginx/
dos2unix /etc/nginx/nginx.conf
chmod 644 /etc/nginx/nginx.conf

# Create SKYNET
mkdir -p {/var/www/html/skynet,/var/www/html/skynet/music,/var/www/html/skynet/store}
cp configs/apache-ha/index-main.html /var/www/html/skynet/index.html
cp configs/apache-ha/index-music.html /var/www/html/skynet/music/index.html
cp configs/apache-ha/index-store.html /var/www/html/skynet/store/index.html

## Install http app
cp -f configs/commons/index.html /var/www/html/
dos2unix /var/www/html/index.html

# Install php app
cp -f configs/commons/info.php /var/www/html
dos2unix /var/www/html/info.php

# Reload Daemon(for systemctl units only)
systemctl daemon-reload

# # Update trusted certificates
# update-ca-trust

# Enable ngix service
systemctl enable nginx
systemctl enable php-fpm

# Check nginx configuration
nginx -t

# Restart ngix service
systemctl restart nginx
systemctl restart php-fpm
