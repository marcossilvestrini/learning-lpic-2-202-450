<h1><a name="readme-top"></a></h1>

[![MIT License][license-shield]][license-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Contributors][contributors-shield]][contributors-url]
[![Issues][issues-shield]][issues-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

# LEARNNING LPIC-2 202-450

![202-450 Linux Engineer](Images/lpic2-202-450.jpg)

<p align="center">
<strong>Explore the docs »</strong></a>
    <br />
    <a href="https://github.com/marcossilvestrini/learning-lpic-2-202-450">Main Page</a>
    -
    <a href="https://github.com/marcossilvestrini/learning-lpic-2-202-450/issues">Report Bug</a>
    -
    <a href="https://github.com/marcossilvestrini/learning-lpic-2-202-450/issues">Request Feature</a>
</p>

## Sumary

<details>
  <summary><b>TABLE OF CONTENT</b></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#instalation">Instalation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#freedoms">Four Essential Freedoms</a></li>
    <li>
      <a href="#topic-207">Topic 207: Domain Name Server</a>
      <ul>
        <li><a href="#topic-207.1">207.1 Basic DNS server configuration</a></li>
        <li><a href="#topic-207.2">207.2 Create and maintain DNS zones</a></li>
        <li><a href="#topic-207.3">207.3 Securing a DNS server </a></li>
      </ul>
    </li>
    <li>
      <a href="#topic-208">Topic 208: HTTP Services</a>
      <ul>
        <li><a href="#topic-208.1">208.1 Basic Apache configuration</a></li>
        <li><a href="#topic-208.2">208.2 Apache configuration for HTTPS</a></li>
        <li><a href="#topic-208.3">208.3 Implementing Squid as a caching proxy</a></li>
        <li><a href="#topic-208.4">208.4 Implementing Nginx as a web server and a reverse proxy</a></li>
      </ul>
    </li>
    <li>
      <a href="#topic-209">Topic 209: File Sharing</a>
      <ul>
        <li><a href="#topic-209.1">209.1 Samba Server Configuration</a></li>
        <li><a href="#topic-209.2">209.2 NFS Server Configuration</a></li>
      </ul>
    </li>
    <li>
      <a href="#topic-210">Topic 210: Network Client Management</a>
      <ul>
        <li><a href="#topic-210.1">210.1 DHCP configuration</a></li>
        <li><a href="#topic-210.2">210.2 PAM authentication</a></li>
        <li><a href="#topic-210.3">210.3 LDAP client usage</a></li>
        <li><a href="#topic-210.4">210.4 Configuring an OpenLDAP server</a></li>
      </ul>
    </li>
    <li>
      <a href="#topic-211">Topic 211: E-Mail Services</a>
      <ul>
        <li><a href="#topic-211.1">211.1 Using e-mail servers</a></li>
        <li><a href="#topic-211.2">211.2 Managing E-Mail Delivery</a></li>
        <li><a href="#topic-211.3">211.3 Managing Mailbox Access</a></li>
      </ul>
    </li>
    <li>
      <a href="#topic-212">Topic 212: System Security</a>
      <ul>
        <li><a href="#topic-212.1">212.1 Configuring a router</a></li>
        <li><a href="#topic-212.2">212.2 Managing FTP servers</a></li>
        <li><a href="#topic-212.3">212.3 Secure shell (SSH)</a></li>
        <li><a href="#topic-212.4">212.4 Security tasks</a></li>
        <li><a href="#topic-212.5">212.5 OpenVPN</a></li>
      </ul>
    </li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details><br>

<a name="about-the-project"></a>

## About Project

>This project aims to help students or professionals to learn the main concepts of GNULinux
and free software\
Some GNULinux distributions like Debian and RPM will be covered\
Installation and configuration of some packages will also be covered\
>By doing this you can give the whole community a chance to benefit from your changes.\
>Access to the source code is a precondition for this.\
>Use vagrant for up machines and execute labs and practice content in this article.\
>I have published in folder Vagrant a Vagrantfile with what is necessary\
for you to upload an environment for studies
>
>Thanks *Sue B.V.*, The Netherlands Open Sourced 2021 for content of learning

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="getting-started"></a>

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

<a name="prerequisites"></a>

### Prerequisites

This is an example of how to list things you need to use the software
and how to install them.

* git
* Virtual Box and extencion
* Vagrant

<a name="instalation"></a>

### Installation

Clone the repo

```sh
git clone https://github.com/marcossilvestrini/learning-lpic-2-202-450.git
```

<a name="usage"></a>

## Usage

Use this repository for get learning about LPIC2 202-450 exam

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="roadmap"></a>

## Roadmap

* [x] Create repository
* [x] Update vagrant box oracle 8 for oracle 9
* [ ] Create examples about Topic 207
* [ ] Create examples about Topic 208
* [ ] Create examples about Topic 209
* [ ] Create examples about Topic 210
* [ ] Create examples about Topic 211
* [ ] Create examples about Topic 212
* [ ] Upload simulated itexam

<a name="freedoms"></a>

## Four Essential Freedoms

>0.The freedom to run the program as you wish, for any purpose (freedom 0).\
>1.The freedom to study how the program works, and change it so it does\
your computing as you wish (freedom 1).\
>Access to the source code is a precondition for this.\
>2.The freedom to redistribute copies so you can help others (freedom 2).\
>3.freedom to distribute copies of your modified versions to others (freedom 3).

## Inspect commands

```sh
type COMMAND
apropos COMMAND
whatis COMMAND --long
whereis COMMAND
COMMAND --help, --h
man COMMAND
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-207"></a>

## Topic 207: Domain Name Server

<a name="topic-207.1"></a>

![Mind Map](Images/domain-name-spaces.jpg)
![Mind Map](Images/dns-types.jpg)

### 207.1 Basic DNS server configuration

**Weight:** 3

**Description:**
Description Candidates should be able to configure BIND to function as an
authoritative and as a recursive, caching-only DNS server.
This objective includes the ability to manage a running server and configuring logging.

**Key Knowledge Areas:**

* BIND 9.x configuration files, terms and utilities
* Defining the location of the BIND zone files in BIND configuration files
* Reloading modified configuration and zone files
* Awareness of dnsmasq, djbdns and PowerDNS as alternate name servers

#### 207.1 Cited Objects

```sh
/etc/named.conf
/var/named/
/var/named/named.ca
/etc/bind/db.root
/usr/share/dns/root.hints
rndc
named-checkconf
kill
host
dig
```

![Mind Map](Images/mindmap-207.1.png)

#### 207.1 Important Commands

##### rndc - name server control utility

```sh
#Check version\status of bind
rndc status

#Reload /etc/named.conf
rndc reload

#reload zone
rndc reload zone ZONE

#clear cache
rndc flush

#reloads  the  configuration  file and loads new zones
rndc reconfig

#Enable customizade logging
rndc querylog

#Enabled trace
rndc trace
```

##### named-checkconf - named configuration file syntax checking tool

```sh
#check if /etc/named.conf is ok
named-checkconf
```

##### named-checkzone - zone file validity checking or converting tool

```sh
#check if your zone file is ok
named-checkzone lpic2.com.br /var/named/lpic2.zone
```

##### whois - client for the whois directory service

```sh
# find infos about nserver
whois lpi.org
```

#### About BIND

##### Install BIND

```sh
#RPM
yum install -y bind bind-utils

#Debian
apt install -y bind9 dnsutils
```

##### Check Status of BIND\named

```sh
#RPM
systemctl status named

#Debian
systemctl status bind9

#Check listen port 53
lsof -n -i :53
lsof -n -i4:53
lsof -n -i6:53
netstat -lutna | grep 53
```

##### Test BIND local

```sh
#localhost, config default
host www.lpi.org localhost
dig  www.lpi.org @localhost

#another ip configurate in listen-on port 53 { 127.0.0.1; 192.168.0.135};
host www.lpi.org 192.168.0.135
dig  www.lpi.org @192.168.0.135
```

#### Add ip for listen on port 53

![Mind Map](Images/bind-add-listen-on-port.gif)

#### Allow network or ip for remote query

![Mind Map](Images/bind-add-allow-query.gif)

#### Configure DNS Caching Only

![Mind Map](Images/bind-set-only-caching.gif)

<p align="right">(<a href="#topic-207.1">back to sub topic 207.1</a>)</p>
<p align="right">(<a href="#topic-207">back to topic 207</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-207.2"></a>

### 207.2 Create and maintain DNS zones

**Weight:** 3

**Description:**

Candidates should be able to create a zone file for a forward or reverse
zone and hints for root level servers. This objective includes setting
appropriate values for records, adding hosts in zones and adding zones to
the DNS. A candidate should also be able to delegate zones to another DNS
server.

**Key Knowledge Areas:**

* BIND 9 configuration files, terms and utilities
* Utilities to request information from the DNS server
* Layout, content and file location of the BIND zone files
* Various methods to add a new host in the zone files, including reverse zones

#### 207.2 Cited Objects

```sh
/var/named/
zone file syntax
resource record formats
named-checkzone
named-compilezone
masterfile-format
dig
nslookup
host
```

![Mind Map](Images/mindmap-207.2.png)

#### 207.2 Important Commands

##### host

```sh
host www.lpi.org localhost
host www.lpi.org 192.168.0.135
```

##### dig

```sh
dig  www.lpi.org @localhost
dig  www.lpi.org @192.168.0.135
dig -4 @192.168.0.141 lpic2.com.br ANY
```

##### named-checkzone

```sh
named-checkzone lpic2.com.br /var/named/lpic2.zone
```

##### named-compilezone

```sh
named-compilezone -f raw -F text -o /tmp/lpic2.txt lpic2.com.br /var/cache/bind/lpic2.zone
```

##### masterfile-format

```sh
#Examples
```

##### nslookup

```sh
nslookup  ol9-bind-caching
nslookup  lpic2.com.br
```

<p align="right">(<a href="#topic-207.2">back to sub topic 207.2</a>)</p>
<p align="right">(<a href="#topic-207">back to topic 207</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-207.3"></a>

### 207.3 Securing a DNS server

**Weight:** 2

**Description:**

Candidates should be able to configure a DNS server to run as a non-root
user and run in a chroot jail. This objective includes secure exchange of
data between DNS servers.

**Key Knowledge Areas:**

* BIND 9 configuration files
* Configuring BIND to run in a chroot jail
* Split configuration of BIND using the forwarders statement
* Configuring and using transaction signatures (TSIG)
* Awareness of DNSSEC and basic tools
* Awareness of DANE and related records

#### 207.3 Cited Objects

```sh
/etc/named.conf
/etc/passwd
DNSSEC
dnssec-keygen
dnssec-signzone
```

![Mind Map](Images/mindmap-207.3.png)

#### 207.3 Importat Commands

```sh
#Examples
```

<p align="right">(<a href="#topic-207.3">back to sub topic 207.3</a>)</p>
<p align="right">(<a href="#topic-207">back to topic 207</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-208"></a>

## Topic 208: HTTP Services

<a name="topic-208.1"></a>

### 208.1 Basic Apache configuration

**Weight:** 4

**Description:**

Candidates should be able to install and configure a web server.
This objective includes monitoring the server's load and performance,
restricting client user access, configuring support for scripting
languages as modules and setting up client user authentication.
Also included is configuring server options to restrict usage of
resources. Candidates should be able to configure a web server to use
virtual hosts and customise file access.

**Key Knowledge Areas:**

* Apache 2.4 configuration files, terms and utilities
* Apache log files configuration and content
* Access restriction methods and files
* mod_perl and PHP configuration
* Client user authentication files and utilities
* Configuration of maximum requests, minimum and maximum servers and clients
* Apache 2.4 virtual host implementation (with and without dedicated IP addresses)
* Using redirect statements in Apache's configuration files to customise file access

#### 208.1 Cited Objects

```sh
access logs and error logs
.htaccess
httpd.conf
mod_auth_basic, mod_authz_host and mod_access_compat
htpasswd
AuthUserFile, AuthGroupFile
apachectl, apache2ctl
httpd, apache2
```

![Mind Map](Images/mindmap-208.1.png)

#### 208.1 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-208.1">back to sub topic 208.1</a>)</p>
<p align="right">(<a href="#topic-201">back to topic 208</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-208.2"></a>

### 208.2 Apache configuration for HTTPS

**Weight:** 3

**Description:**

Candidates should be able to configure a web server to provide HTTPS.

**Key Knowledge Areas:**

* SSL configuration files, tools and utilities
* Generate a server private key and CSR for a commercial CA
* Generate a self-signed Certificate
* Install the key and certificate, including intermediate CAs
* Configure Virtual Hosting using SNI
* Awareness of the issues with Virtual Hosting and use of SSL
* Security issues in SSL use, disable insecure protocols and ciphers

#### 201.2 Cited Objects

```sh
Apache2 configuration files
/etc/ssl/, /etc/pki/
openssl, CA.pl
SSLEngine, SSLCertificateKeyFile, SSLCertificateFile
SSLCACertificateFile, SSLCACertificatePath
SSLProtocol, SSLCipherSuite, ServerTokens, ServerSignature, TraceEnable
```

![Mind Map](Images/mindmap-208.2.png)

#### 208.2 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-208.2">back to sub topic 208.2</a>)</p>
<p align="right">(<a href="#topic-208">back to topic 208</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-208.3"></a>

### 208.3 Implementing Squid as a caching proxy

**Weight:** 2

**Description:**

Candidates should be able to install and configure a proxy server,
including access policies, authentication and resource usage.

**Key Knowledge Areas:**

* Squid 3.x configuration files, terms and utilities
* Access restriction methods
* Client user authentication methods
* Layout and content of ACL in the Squid configuration files

#### 208.3 Cited Objects

```sh
squid.conf
acl
http_access
```

![Mind Map](Images/mindmap-208.3.png)

#### 208.3 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-208.3">back to sub topic 208.3</a>)</p>
<p align="right">(<a href="#topic-208">back to topic 208</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-208.4"></a>

### 208.4 Implementing Nginx as a web server and a reverse proxy

**Weight:** 2

**Description:**

Candidates should be able to install and configure a reverse proxy server,
Nginx.
Basic configuration of Nginx as a HTTP server is included.

**Key Knowledge Areas:**

Nginx
Reverse Proxy
Basic Web Server

#### 208.4 Cited Objects

```sh
/etc/nginx/
nginx
```

![Mind Map](Images/mindmap-208.4.png)

#### 208.4 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-208.4">back to sub topic 208.4</a>)</p>
<p align="right">(<a href="#topic-208">back to topic 208</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-209"></a>

## Topic 202: File Sharing

<a name="topic-209.1"></a>

### 209.1 Samba Server Configuration

**Weight:** 5

**Description:**

Candidates should be able to set up a Samba server for various clients.
This objective includes setting up Samba as a standalone server as well as
integrating Samba as a member in an Active Directory. Furthermore, the
configuration of simple CIFS and printer shares is covered. Also covered
is a configuring a Linux client to use a Samba server. Troubleshooting
installations is also tested.

**Key Knowledge Areas:**

* Samba 4 documentation
* Samba 4 configuration files
* Samba 4 tools and utilities and daemons
* Mounting CIFS shares on Linux
* Mapping Windows user names to Linux user names
* User-Level, Share-Level and AD security

#### 209.1 Cited Objects

```sh
smbd, nmbd, winbindd
smbcontrol, smbstatus, testparm, smbpasswd, nmblookup
samba-tool
net
smbclient
mount.cifs
/etc/samba/
/var/log/samba/
```

![Mind Map](Images/mindmap-209.1.png)

#### 209.1 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-209.1">back to sub topic 209.1</a>)</p>
<p align="right">(<a href="#topic-209">back to topic 209</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-209.2"></a>

### 209.2 NFS Server Configuration

**Weight:** 3

**Description:**
Candidates should be able to export filesystems using NFS. This objective
includes access restrictions, mounting an NFS filesystem on a client and
securing NFS.

**Key Knowledge Areas:**

* NFS version 3 configuration files
* NFS tools and utilities
* Access restrictions to certain hosts and/or subnets
* Mount options on server and client
* TCP Wrappers
* Awareness of NFSv4

#### 202.2 Cited Objects

```sh
/etc/exports
exportfs
showmount
nfsstat
/proc/mounts
/etc/fstab
rpcinfo
mountd
portmapper
```

![Mind Map](Images/mindmap-209.2.png)

#### 209.2 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-209.2">back to sub topic 209.2</a>)</p>
<p align="right">(<a href="#topic-202">back to topic 209</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-210"></a>

## Topic 210: Network Client Management



<a name="topic-210.1"></a>

### 210.1 DHCP configuration

**Weight:** 2

**Description:**
Candidates should be able to configure a DHCP server.
This objective includes setting default and per client options, adding
static hosts and BOOTP hosts. Also included is configuring a DHCP relay
agent and maintaining the DHCP server.

**Key Knowledge Areas:**

* DHCP configuration files, terms and utilities
* Subnet and dynamically-allocated range setup
* Awareness of DHCPv6 and IPv6 Router Advertisements

#### 210.1 Cited Objects

```sh
dhcpd.conf
dhcpd.leases
DHCP Log messages in syslog or systemd journal
arp
dhcpd
radvd
radvd.conf
```

![Mind Map](Images/mindmap-210.1.png)

#### 210.1 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-210.1">back to sub topic 210.1</a>)</p>
<p align="right">(<a href="#topic-202">back to topic 210</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-210.2"></a>

### 210.2 PAM authentication

**Weight:** 3

**Description:**
The candidate should be able to configure PAM to support authentication
using various available methods. This includes basic SSSD functionality.

**Key Knowledge Areas:**

* PAM configuration files, terms and utilities
* passwd and shadow passwords
* Use sssd for LDAP authentication

#### 210.2 Cited Objects

```sh
/etc/pam.d/
pam.conf
nsswitch.conf
pam_unix, pam_cracklib, pam_limits, pam_listfile, pam_sss
sssd.conf
```

![Mind Map](Images/mindmap-210.2.png)

#### 210.2 Importat Commands

```sh
Examples
```

<p align="right">(<a href="#topic-210.2">back to sub topic 210.2</a>)</p>
<p align="right">(<a href="#topic-203">back to topic 210</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-210.3"></a>

### 210.3 LDAP client usage

**Weight:** 2

**Description:**
Candidates should be able to properly maintain a Linux filesystem using
system utilities.
This objective includes manipulating standard filesystems and monitoring
SMART devices.

**Key Knowledge Areas:**

* LDAP utilities for data management and queries
* Change user passwords
* Querying the LDAP directory

#### 203.2 Cited Objects

```sh
ldapsearch
ldappasswd
ldapadd
ldapdelete
```

![Mind Map](Images/mindmap-210.3.png)


#### 210.3 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-210.3">back to sub topic 210.3</a>)</p>
<p align="right">(<a href="#topic-203">back to topic 210</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-210.4"></a>

### 210.4 Configuring an OpenLDAP server

**Weight:** 4

**Description:**
Candidates should be able to configure automount filesystems using AutoFS.
This objective includes configuring automount for network and device
filesystems.
Also included is creating filesystems for devices such as CD-ROMs and a
basic feature knowledge of encrypted filesystems.

**Key Knowledge Areas:**

* OpenLDAP
* Directory based configuration
* Access Control
* Distinguished Names
* Changetype Operations
* Schemas and Whitepages
* Directories
* Object IDs, Attributes and Classes

#### 210.4 Cited Objects

```sh
slapd
slapd-config
LDIF
slapadd
slapcat
slapindex
/var/lib/ldap/
loglevel
```

![Mind Map](Images/mindmap-210.4.png)

#### 210.4 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-210.4">back to sub topic 210.4</a>)</p>
<p align="right">(<a href="#topic-210">back to topic 210</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-211"></a>

## Topic 211: E-Mail Services

<a name="topic-211.1"></a>

### 211.1 Using e-mail servers

**Weight:** 4

**Description:**
Candidates should be able to manage an e-mail server, including the
configuration of e-mail aliases, e-mail quotas and virtual e-mail domains.
This objective includes configuring internal e-mail relays and monitoring
e-mail servers.

**Key Knowledge Areas:**

* Configuration files for postfix
* Basic TLS configuration for postfix
* Basic knowledge of the SMTP protocol
* Awareness of sendmail and exim

#### 204.1 Cited Objects

```sh
Configuration files and commands for postfix
/etc/postfix/
/var/spool/postfix/
sendmail emulation layer commands
/etc/aliases
mail-related logs in /var/log/
```

![Mind Map](Images/mindmap-211.1.png)

#### 211.1 Important commands

```sh
Examples
```

<p align="right">(<a href="#topic-211.1">back to sub topic 211.1</a>)</p>
<p align="right">(<a href="#topic-211">back to topic 211</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-211.2"></a>

### 211.2  Managing E-Mail Delivery

**Weight:**2

**Description:**
Candidates should be able to implement client e-mail management software
to filter, sort and monitor incoming user e-mail.

**Key Knowledge Areas:**

* Understanding of Sieve functionality, syntax and operators
* Use Sieve to filter and sort mail with respect to sender, recipient(s)headers and size
* Awareness of procmail

#### 211.2 Cited Objects

```sh
Conditions and comparison operators
keep, fileinto, redirect, reject, discard, stop
Dovecot vacation extension
```

![Mind Map](Images/mindmap-204.2.png)

#### 211.2 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-211.2">back to sub topic 211.2</a>)</p>
<p align="right">(<a href="#topic-211">back to topic 211</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-211.3"></a>

### 211.3 Managing Mailbox

**Weight:** 2

**Description:**
Candidates should be able to install and configure POP and IMAP daemons.

**Key Knowledge Areas:**

* Dovecot IMAP and POP3 configuration and administration
* Basic TLS configuration for Dovecot
* Awareness of Courier

#### 204.3  Cited Object

```sh
/etc/dovecot/
dovecot.conf
doveconf
doveadm
```

![Mind Map](Images/mindmap-211.3.png)

<p align="right">(<a href="#topic-211.3">back to sub topic 211.3</a>)</p>
<p align="right">(<a href="#topic-211">back to topic 211</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-212"></a>

## Topic 212: System Security

<a name="topic-212.1"></a>

### 212.1 Configuring a router

**Weight:** 3

**Description:**
Candidates should be able to configure a system to forward IP packet and
perform network address translation (NAT, IP masquerading) and state its
significance in protecting a network. This objective includes configuring
port redirection, managing filter rules and averting attacks.

**Key Knowledge Areas:**

* iptables and ip6tables configuration files, tools and utilities
* Tools, commands and utilities to manage routing tables.
* Private address ranges (IPv4) and Unique Local Addresses as well as Link * Local Addresses (IPv6)
* Port redirection and IP forwarding
* List and write filtering and rules that accept or block IP packets based on source or destination protocol, port and address
* Save and reload filtering configurations

#### 212.1 Cited Object

```sh
/proc/sys/net/ipv4/
/proc/sys/net/ipv6/
/etc/services
iptables
ip6tables
```

![Mind Map](Images/mindmap-212.1.png)

#### 212.1 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-212.1">back to sub topic 212.1</a>)</p>
<p align="right">(<a href="#topic-212">back to topic 205</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-212.2"></a>

### 212.2 Managing FTP servers

**Weight:** 2

**Description:**
Candidates should be able to configure an FTP server for anonymous
downloads and uploads. This objective includes precautions to be taken if
anonymous uploads are permitted and configuring user access.

**Key Knowledge Areas:**

* Configuration files, tools and utilities for Pure-FTPd and vsftpd
* Awareness of ProFTPd
* Understanding of passive vs. active FTP connections

#### 212.2 Cited Objects

```sh
ip
ifconfig
route
arp
ss
netstat
lsof
ping, ping6
nc
tcpdump
nmap
```

![Mind Map](Images/mindmap-212.2.png)

#### 212.2 Important Commands

```ssh
Examples
```

<p align="right">(<a href="#topic-212.2">back to sub topic 212.2</a>)</p>
<p align="right">(<a href="#topic-212">back to topic 212</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-212.3"></a>

### 212.3 Secure shell

**Weight:** 4

**Description:**
Candidates should be able to identify and correct common network setup
issues,to include knowledge of locations for basic configuration files and
commands.

**Key Knowledge Areas:**

* OpenSSH configuration files, tools and utilities
* Login restrictions for the superuser and the normal users
* Managing and using server and client keys to login with and without password
* Usage of multiple connections from multiple hosts to guard against loss
of connection to remote host following configuration changes

#### 212.3 Cited Objects

```sh
ssh
sshd
/etc/ssh/sshd_config
/etc/ssh/
Private and public key files
PermitRootLogin, PubKeyAuthentication, AllowUsers,
PasswordAuthentication, Protocol

```

![Mind Map](Images/mindmap-212.3.png)

#### 212.3 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-212.3">back to sub topic 212.3</a>)</p>
<p align="right">(<a href="#topic-212">back to topic 212</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-212.4"></a>

### 212.4 Security tasks

**Weight:**3

**Description:**
Candidates should be able to receive security alerts from various sources,
install, configure and run intrusion detection systems and apply security
patches and bugfixes.

**Key Knowledge Areas:**

* Tools and utilities to scan and test ports on a server
* Locations and organisations that report security alerts as Bugtraq, CERT
or other sources
* Tools and utilities to implement an intrusion detection system (IDS)
* Awareness of OpenVAS and Snort

#### 212.4 Cited Objects

```sh
telnet
nmap
fail2ban
nc
iptables
```

![Mind Map](Images/mindmap-212.4.png)

#### 212.4 Important Commands

```sh
Examples
```

<p align="right">(<a href="#topic-212.4">back to sub topic 212.4</a>)</p>
<p align="right">(<a href="#topic-212">back to topic 212</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<a name="topic-212.5"></a>

### 212.5 OpenVPN

**Weight:** 2

**Description:**
Candidates should be able to configure a VPN (Virtual Private Network) and
create secure point-to-point or site-to-site connections.

**Key Knowledge Areas:**

* OpenVPN

#### 212.5 Cited Objects

```sh
/etc/openvpn/
openvpn
```

![Mind Map](Images/mindmap-212.5.png)

<p align="right">(<a href="#topic-212.5">back to sub topic 212.5</a>)</p>
<p align="right">(<a href="#topic-212">back to topic 212</a>)</p>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contributing

Contributions are what make the open source community such an amazing place to
learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and
create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

* This project is licensed under the MIT License * see the LICENSE.md file for details

## Contact

Marcos Silvestrini - marcos.silvestrini@gmail.com \
[![Twitter](https://img.shields.io/twitter/url/https/twitter.com/mrsilvestrini.svg?style=social&label=Follow%20%40mrsilvestrini)](https://twitter.com/mrsilvestrini)

Project Link: [https://github.com/marcossilvestrini/learning-lpic-2-202-450](https://github.com/marcossilvestrini/learning-lpic-2-202-450)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Acknowledgments

* [Richard Stallman's](http://www.stallman.org/)
* [GNU/Linux FAQ by Richard Stallman](https://www.gnu.org/gnu/gnu-linux-faq.html)
* [GNU](https://www.gnu.org/)
* [GNU Operating System](https://www.gnu.org/gnu/thegnuproject.html)
* [GCC Compiler](https://gcc.gnu.org/wiki/History)
* [GNU Tar](https://www.gnu.org/software/tar/)
* [GNU Make](https://www.gnu.org/software/make/)
* [GNU Emacs](https://en.wikipedia.org/wiki/Emacs)
* [GNU Packages](https://www.gnu.org/software/)
* [GNU/Linux Collection](https://directory.fsf.org/wiki/Collection:GNU/Linux)
* [GNU Grub Bootloader](https://www.gnu.org/software/grub/)
* [GNU Hurd](https://www.gnu.org/software/hurd/hurd/what_is_the_gnu_hurd.html)
* [Kernel](https://www.kernel.org/)
* [Linux Kernel Man Pages](https://www.kernel.org/doc/man-pages/)
* [Linux Standard Base](https://en.wikipedia.org/wiki/Linux_Standard_Base)
* [Filesystem Hierarchy Standard](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard)
* [File Hierarchy Structure](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.pdf)
* [FSF](https://www.fsf.org)
* [Free Software Directory](https://directory.fsf.org/wiki/Free_Software_Directory:Free_software_replacements)
* [Free Software](https://www.gnu.org/philosophy/free-sw.html)
* [Copyleft](https://www.gnu.org/licenses/copyleft.en.html)
* [GPL](https://www.gnu.org/licenses/quick-guide-gplv3.html)
* [GNU Lesser General Public License](https://www.gnu.org/licenses/lgpl-3.0.html)
* [BSD](https://opensource.org/licenses/BSD-3-Clause)
* [Open Source Initiative](https://opensource.org/)
* [Creative Commons](https://creativecommons.org/)
* [License LTS](https://en.wikipedia.org/wiki/Long-term_support)
* [Debian Free Software Guidelines](https://www.debian.org/social_contract#guidelines)
* [X11 Org](https://www.x.org/wiki/)
* [Wayland](https://wayland.freedesktop.org/)
* [GNU GNOME](https://www.gnu.org/press/gnome-1.0.html)
* [GNOME](https://www.gnome.org/)
* [XFCE](https://xfce.org/)
* [KDE Plasma](https://kde.org/plasma-desktop/)
* [Harmony](https://en.wikipedia.org/wiki/Harmony_(toolkit))
* [xRDP](https://bytexd.com/xrdp-centos/)
* [NTP](https://www.ntppool.org/en/)
* [Bourne Again Shell](https://www.gnu.org/software/bash/manual/)
* [Shebang](https://bash.cyberciti.biz/guide/Shebang)
* [Environment Variables](https://linuxize.com/post/how-to-set-and-list-environment-variables-in-linux/)
* [GNU Globbing](https://man7.org/linux/man-pages/man7/glob.7.html)
* [Globbing](https://linuxhint.com/bash_globbing_tutorial/)
* [Quoting](https://www.gnu.org/software/bash/manual/html_node/Quoting.html)
* [Regular Expressions](https://www.gnu.org/software/grep/manual/html_node/Regular-Expressions.html)
* [List Linux Distribution](https://en.wikipedia.org/wiki/List_of_Linux_distributions)
* [Distro Watch](https://distrowatch.com/)
* [Comparison Linux Distributions](https://en.wikipedia.org/wiki/Comparison_of_Linux_distributions)
* [Download Packages](https://pkgs.org/)
* [Guide Install Packages](https://installati.one/)
* [Bugzila](https://bugzilla.kernel.org/)
* [Command Not Found](https://command-not-found.com/)
* [DistroTest](https://distrotest.net/index.php)
* [Bash RC Generator](http://bashrcgenerator.com/)
* [Explainshell](https://explainshell.com/)
* [Vim Tutorial](https://www.openvim.com/)
* [Linux Shell Scripting Tutorial](https://bash.cyberciti.biz/guide/Main_Page)
* [Github Badges](https://github.com/alexandresanlim/Badges4-README.md-Profile)
* [Commands Examples](https://www.geeksforgeeks.org/)
* [Compile Your Kernel](https://wiki.linuxquestions.org/wiki/How_to_build_and_install_your_own_Linux_kernel)
* [Bind Logging](https://www.zytrax.com/books/dns/ch7/logging.html)
* [List of DNS record types](https://en.wikipedia.org/wiki/List_of_DNS_record_types)
* [LPIC-2 202-450 Objectives](https://www.lpi.org/our-certifications/exam-202-objectives)
* [LPIC-2 202-450 Wiki](https://wiki.lpi.org/wiki/LPIC-2_Objectives_V4.5#Objectives:_Exam_202)
* [LPIC-2 202-450 Learning Material](https://lpic2book.github.io/src/)
* [LPIC-2 202-450 Simulated Exam By ITexams](https://www.itexams.com/exam/202-450)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[contributors-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[forks-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/network/members
[stars-shield]: https://img.shields.io/github/stars/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[stars-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/stargazers
[issues-shield]: https://img.shields.io/github/issues/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[issues-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/issues
[license-shield]: https://img.shields.io/github/license/marcossilvestrini/learning-lpic-2-202-450.svg?style=for-the-badge
[license-url]: https://github.com/marcossilvestrini/learning-lpic-2-202-450/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/marcossilvestrini
