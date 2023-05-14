#!/bin/bash

# Installation des paquets nécessaires pour FTP, DNS et DHCP
sudo apt-get update
sudo apt-get -y install vsftpd bind9 isc-dhcp-server

# Configuration du serveur FTP
sudo sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf
sudo systemctl restart vsftpd

# Configuration du serveur DNS
sudo sed -i 's/127.0.0.1/localhost/' /etc/bind/named.conf.options
sudo cp /etc/bind/db.local /etc/bind/db.yourdomain.com
sudo sed -i 's/localhost/yourdomain.com/g' /etc/bind/db.yourdomain.com
sudo sed -i 's/root.localhost/root.yourdomain.com/g' /etc/bind/db.yourdomain.com
sudo sed -i 's/@/admin.yourdomain.com./g' /etc/bind/db.yourdomain.com
sudo sed -i 's/127.0.0.1/localhost/g' /etc/bind/named.conf.options
sudo systemctl restart bind9

# Configuration du serveur DHCP
sudo sed -i 's/option domain-name "example.org";/# option domain-name "example.org";/' /etc/dhcp/dhcpd.conf
sudo sed -i 's/#authoritative;/authoritative;/' /etc/dhcp/dhcpd.conf
sudo sed -i '/# The next statement terminates declarations of./a option domain-name "yourdomain.com";' /etc/dhcp/dhcpd.conf
sudo sed -i '/# The next statement terminates declarations of./a option domain-name-servers 192.168.0.1;' /etc/dhcp/dhcpd.conf
sudo sed -i '/# A slightly different configuration for an internal subnet./a subnet 192.168.0.0 netmask 255.255.255.0 { range 192.168.0.50 192.168.0.150; option routers 192.168.0.1; }' /etc/dhcp/dhcpd.conf
sudo systemctl restart isc-dhcp-server

echo "Le serveur FTP/DNS/DHCP a été installé avec succès."
