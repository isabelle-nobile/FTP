#!/bin/bash

# Désinstaller le serveur FTP et supprimer les fichiers de configuration
sudo apt-get remove vsftpd
sudo rm -rf /etc/vsftpd

# Supprimer les utilisateurs FTP et leurs répertoires personnels
sudo awk -F':' '/^ftp/{print $1}' /etc/passwd | xargs sudo deluser --remove-home

# Supprimer les groupes associés au serveur FTP
sudo groupdel ftp
sudo groupdel ftpaccess

# Supprimer les règles de pare-feu liées au serveur FTP
sudo ufw delete allow ftp
sudo ufw delete allow ftp-data

# Redémarrer le service de pare-feu
sudo systemctl restart ufw

echo "Le serveur FTP a été désinstallé avec succès."
