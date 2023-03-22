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


# # Tunning apache

# ## Configure /etc/httpd/conf/httpd.conf
# #-rw-r--r--. 1 root root 12005 Oct  6 07:39 /etc/httpd/conf/httpd.conf
# cp -p /etc/httpd/conf/httpd.conf configs/apache-ha/httpd.conf_backup
# cp -f configs/apache-ha/httpd.conf /etc/httpd/conf/
# dos2unix /etc/httpd/conf/httpd.conf
# chmod 644 /etc/httpd/conf/httpd.conf

# ## Configure MPM mod
# cp -f configs/apache-ha/00-mpm.conf /etc/httpd/conf.modules.d
# dos2unix /etc/httpd/conf.modules.d/00-mpm.conf
# chmod 644 /etc/httpd/conf.modules.d/00-mpm.conf

# # Create user autentication db for sites
# mkdir /etc/httpd/htpasswd
# echo "vagrant" | htpasswd -c -i /etc/httpd/htpasswd/.htpasswd vagrant
# echo "silvestrini" | htpasswd -i /etc/httpd/htpasswd/.htpasswd silvestrini
# echo "lpic2" | htpasswd -i /etc/httpd/htpasswd/.htpasswd lpic2
# cp  configs/commons/.htgroup /etc/httpd/htpasswd
# dos2unix /etc/httpd/htpasswd/.htgroup

# # Create sites for autentication rules
# mkdir {/var/www/html/topsecret,/var/www/html/admin}
# touch /var/www/html/topsecret/topsecret_file{1..3}
# touch /var/www/html/admin/admin_file{1..3}

# # Set sites for autentication rules(mod_authn)
# cp configs/commons/.htaccess /var/www/html/topsecret
# cp configs/commons/.htaccess /var/log/httpd
# chmod 755 /var/log/httpd/
# dos2unix /var/www/html/topsecret/.htaccess
# dos2unix /var/log/httpd/.htaccess

# # Set sites for autorization rules (mod_authz)
# cp configs/commons/.htaccess_admin /var/www/html/admin/.htaccess
# dos2unix /var/www/html/admin/.htaccess

# # Create SKYNET and set: Virtualhost, alias and redirects
# cp configs/apache-ha/site-skynet.conf /etc/httpd/conf.d/
# dos2unix /etc/httpd/conf.d/site-skynet.conf
# chmod 644 /etc/httpd/conf.d/site-skynet.conf
# mkdir {/var/www/html/skynet,/var/www/html/skynet/music,/var/www/html/skynet/store}
# cp configs/apache-ha/index-main.html /var/www/html/skynet/index.html
# cp configs/apache-ha/index-music.html /var/www/html/skynet/music/index.html
# cp configs/apache-ha/index-store.html /var/www/html/skynet/store/index.html
# mkdir /var/www/html/skynet/docs
# touch /var/www/html/skynet/docs/doc{1..6}

# # Create FINANCE and set: Virtualhost, alias and redirects
# cp configs/apache-ha/site-finance.conf /etc/httpd/conf.d/
# dos2unix /etc/httpd/conf.d/site-finance.conf
# chmod 644 /etc/httpd/conf.d/site-finance.conf
# mkdir /var/www/html/finance
# cp configs/apache-ha/index-finance.html /var/www/html/finance/index.html


# ## Install http app
# cp -f configs/commons/index.html /var/www/html/
# dos2unix /var/www/html/index.html

# # Install php app
# dnf install -y php-{common,gmp,fpm,curl,intl,pdo,mbstring,gd,xml,cli,zip,mysqli}
# mkdir /var/www/html/skynet/php
# cp -f configs/commons/info.php /var/www/html/skynet/php
# dos2unix /var/www/html/skynet/php/info.php

# # Install perl app (https://techexpert.tips/apache/perl-cgi-apache/)
# dnf install -y perl
# cp configs/apache-ha/perl.conf /etc/httpd/conf.d/
# dos2unix /etc/httpd/conf.d/perl.conf
# chmod 644 /etc/httpd/conf.d/perl.conf
# mkdir /var/www/html/skynet/perl
# cp configs/commons/app.pl /var/www/html/skynet/perl
# dos2unix /var/www/html/skynet/perl/app.pl
# chmod -R 755 /var/www/html/skynet/perl/app.pl

# # Reload Daemon(for systemctl units only)
# systemctl daemon-reload

# # Update trusted certificates
# update-ca-trust

# # Restart apache service
# apachectl configtest
# apachectl restart

# # Configure Squid

# ## Configure main file
# # -rw-r-----. 1 root squid 2526 Nov 16 08:15 /etc/squid/squid.conf
# cp -p /etc/squid/squid.conf configs/apache-ha/squid.conf_backup
# cp -f configs/apache-ha/squid.conf /etc/squid
# dos2unix /etc/squid/squid.conf
# chmod 640 /etc/squid/squid.conf

# ## Create cache directories
# squid -z

# ## Set ACL's
# cp configs/commons/squid-banned-sites /etc/squid
# dos2unix /etc/squid/squid-banned-sites
# chmod 644 /etc/squid/squid-banned-sites

# ## Create autentication file
# echo "vagrant" | htpasswd -c -i /etc/squid/.htpasswd vagrant
# echo "silvestrini" | htpasswd -i /etc/squid/.htpasswd silvestrini
# echo "lpic2" | htpasswd -i /etc/squid/.htpasswd lpic2

# ## Reload squid configuration
# #squid -k reconfigure
# systemctl enable squid
# systemctl restart squid