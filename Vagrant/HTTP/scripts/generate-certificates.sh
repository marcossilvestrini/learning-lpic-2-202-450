#!/bin/bash

<<'MULTILINE-COMMENT'
    Requirments: none
    Description: Script for generate certificates for apache
    Author: Marcos Silvestrini
    Date: 20/03/2023
MULTILINE-COMMENT

export LANG=C

cd /home/vagrant || exit

# Variables
CA_EXTFILE="/etc/ssl/ca_cert.cnf"
CA_CRT="/etc/ssl/certs/lpic2.com.br-ca-cert.pem"
CA_KEY="/etc/ssl/certs/lpic2.com.br-ca-key.pem"
SERVER_EXT="/etc/ssl/server_ext.cnf"
SERVER_CONF="/etc/ssl/server_cert.cnf"
SERVER_KEY="/etc/ssl/certs/lpic2.com.br-server-key.pem"
SERVER_CSR="/etc/ssl/certs/lpic2.com.br-server-req.pem"
SERVER_CRT="/etc/ssl/certs/lpic2.com.br-server-cert.pem"
CLIENT_EXT="/etc/ssl/client_ext.cnf"
CLIENT_CONF="/etc/ssl/client_cert.cnf"
CLIENT_KEY="/etc/ssl/certs/lpic2.com.br-client-key.pem"
CLIENT_CSR="/etc/ssl/certs/lpic2.com.br-client-req.pem"
CLIENT_CRT="/etc/ssl/certs/lpic2.com.br-client-cert.pem"
CLIENT_P12="/etc/ssl/certs/lpic2.com.br-client-cert.p12"

# Creating the Certificate Authority's Certificate and Keys

## Generate a private key for the CA:
rm /etc/ssl/certs/*.pem
cp -f configs/apache-ha/ca_cert.cnf $CA_EXTFILE
dos2unix $CA_EXTFILE
openssl genrsa -out $CA_KEY 4096 2>/dev/null
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $CA_KEY"

## Generate the X509 certificate for the CA:
openssl \
req \
-new \
-x509 \
-nodes \
-days 30 \
-passout pass:vagrant \
-config $CA_EXTFILE \
-key $CA_KEY \
-out $CA_CRT 2>/dev/null

[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $CA_CRT"
openssl  x509 -noout -text -in $CA_CRT >/dev/null 2>&1
[[ $? -ne 0 ]] && echo "ERROR: Failed to read $CA_CRT"

# Creating the Server's Certificate and Keys

## Generate the private key and certificate request:
cp -f configs/apache-ha/server_cert.cnf $SERVER_CONF
cp -f configs/apache-ha/server_ext.cnf $SERVER_EXT
dos2unix $SERVER_CONF
dos2unix $SERVER_EXT
openssl \
req \
-newkey rsa:4096 \
-nodes \
-days 30 \
-passout pass:vagrant \
-config $SERVER_CONF \
-keyout $SERVER_KEY \
-out $SERVER_CSR  2>/dev/null
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $SERVER_CSR"

## Generate the X509 certificate for the server:
openssl \
x509 \
-req \
-in $SERVER_CSR \
-CA $CA_CRT \
-CAkey $CA_KEY \
-out $SERVER_CRT \
-CAcreateserial \
-days 30 \
-sha512 \
-extfile $SERVER_EXT
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $SERVER_CRT"
openssl verify -CAfile $CA_CRT $SERVER_CRT >/dev/null 2>&1
[[ $? -ne 0 ]] && echo "ERROR: Failed to verify $SERVER_CRT against $CA_CRT"

# Creating the Client's Certificate and Keys

## Generate the private key and certificate request:
cp -f configs/apache-ha/client_cert.cnf $CLIENT_CONF
cp -f configs/apache-ha/server_ext.cnf $CLIENT_EXT
dos2unix $CLIENT_CONF
dos2unix $CLIENT_EXT
openssl \
req \
-newkey rsa:4096 \
-nodes \
-days 30 \
-passout pass:vagrant \
-config $CLIENT_CONF \
-keyout $CLIENT_KEY \
-out $CLIENT_CSR  2>/dev/null
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $SERVER_CSR"

## Generate the X509 certificate for the client:
openssl \
x509 \
-req \
-in $CLIENT_CSR \
-CA $CA_CRT \
-CAkey $CA_KEY \
-out $CLIENT_CRT \
-CAcreateserial \
-days 30 \
-sha512 \
-extfile $CLIENT_EXT
[[ $? -ne 0 ]] && echo "ERROR: Failed to generate $CLIENT_CRT"
openssl verify -CAfile $CA_CRT $CLIENT_CRT >/dev/null 2>&1
[[ $? -ne 0 ]] && echo "ERROR: Failed to verify $CLIENT_CRT against $CA_CRT"

## Generate the pkc12 certificate for the client:
openssl pkcs12 \
-export \
-inkey $CLIENT_KEY \
-in $CLIENT_CRT \
-out $CLIENT_P12 \
-passout pass:vagrant 

# Verifying the Certificates

## Verify the CA server certificate:
openssl verify -CAfile $CA_CRT $CA_CRT
#certtool -i < /etc/ssl/certs/lpic2.com.br-ca-cert.pem
#openssl x509 -noout -text -in $CA_CRT

## Verify the server certificate:
openssl verify -CAfile $CA_CRT $SERVER_CRT
#certtool -i < /etc/ssl/certs/lpic2.com.br-server-cert.pem
#openssl x509 -noout -text -in $SERVER_CRT

## Verify the client certificate:
openssl verify -CAfile $CA_CRT $CLIENT_CRT
#certtool -i < /etc/ssl/certs/lpic2.com.br-client-cert.pem
#openssl x509 -noout -text -in $CLIENT_CRT

# Reload Daemon(for systemctl units only)
systemctl daemon-reload

# Update trusted certificates
update-ca-trust

# Copy certificates for share
cp -p /etc/ssl/certs/lpic2.com.br-ca-cert.pem /etc/ssl/certs/lpic2.com.br-client-cert.p12 configs/commons

# Restart apache service
apachectl configtest
apachectl restart
