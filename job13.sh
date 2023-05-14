#!/bin/bash

# Récupérer le chemin absolu du fichier CSV contenant les informations des utilisateurs
users_file="/path/to/users.csv"

# Boucle pour parcourir chaque ligne du fichier CSV et créer les utilisateurs
while IFS=',' read -r username password role
do
  # Créer l'utilisateur
  sudo useradd -m $username -p $(openssl passwd -1 $password)

  # Autoriser l'accès au FTP
  sudo usermod -a -G ftp $username

  # Si le rôle de l'utilisateur est 'admin', lui donner les droits sudo
  if [ $role = "admin" ]; then
    sudo usermod -a -G sudo $username
  fi

  # Créer le répertoire /home de l'utilisateur et le rendre propriétaire
  sudo mkdir /home/$username
  sudo chown $username:$username /home/$username

done < "$users_file"
