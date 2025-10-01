#!/bin/bash

db_name="${db_name}"
db_user="${db_user}"
db_password="${db_password}"
db_host="${db_host}"

wordpress_dir="/var/www/html"

# Mise à jour du système
sudo yum update -y

# Installer les dépendances pour PHP 7.4
sudo yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum install -y yum-utils
sudo yum module reset php -y
sudo yum module enable php:remi-7.4 -y  # Changez ici pour PHP 7.4, ou 8.0 si vous le souhaitez
sudo yum install -y php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap}

# Installer Apache et autres dépendances
sudo yum install -y httpd wget unzip

# Démarrer et activer Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Ajouter l'utilisateur ec2 à Apache
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache ${wordpress_dir}
sudo chmod 2775 ${wordpress_dir}
find ${wordpress_dir} -type d -exec chmod 2775 {} \;
find ${wordpress_dir} -type f -exec chmod 0664 {} \;

# Télécharger et installer WordPress
cd /home/ec2-user
wget https://wordpress.org/latest.zip
unzip latest.zip
mv wordpress/* ${wordpress_dir}

# Configurer le fichier wp-config.php
cp ${wordpress_dir}/wp-config-sample.php ${wordpress_dir}/wp-config.php
sed -i "s/database_name_here/${db_name}/" ${wordpress_dir}/wp-config.php
sed -i "s/username_here/${db_user}/" ${wordpress_dir}/wp-config.php
sed -i "s/password_here/${db_password}/" ${wordpress_dir}/wp-config.php
sed -i "s/localhost/${db_host}/" ${wordpress_dir}/wp-config.php

# Définir les permissions pour le répertoire WordPress
find ${wordpress_dir} -type d -exec chmod 755 {} \;
find ${wordpress_dir} -type f -exec chmod 644 {} \;

# Redémarrer Apache
sudo systemctl restart httpd

echo "🎉 WordPress installé et connecté à la DB RDS avec succès !"
