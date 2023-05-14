#!/bin/bash

# Définir la date et l'heure actuelles
current_date=$(date +%d-%m-%Y_%H:%M)

# Créer une archive avec la date actuelle dans le nom
backup_file="backup_$current_date.tar.gz"

# Répertoire à sauvegarder
backup_dir="/home/user/"

# Compresser les fichiers dans une archive
tar -czvf $backup_file $backup_dir

# Envoyer l'archive à une autre machine (adresse IP à remplacer par l'adresse de la machine destinataire)
scp $backup_file user@192.168.1.2:/home/user/backups/

# Supprimer l'archive locale
rm $backup_file
