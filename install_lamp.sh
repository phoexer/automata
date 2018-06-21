#!/bin/sh

echo "Starting Setup."

apt-get update

apt-get install software-properties-common
add-apt-repository ppa:certbot/certbot

apt-get update

apt-get install -y apache2

ufw allow in "Apache Full"

apt-get install -y mysql-server

mysql_secure_installation

#apt-get install php libapache2-mod-php php-mcrypt php-mysql 
apt-get install -y php7.0 php-pear libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json php7.0-cgi

systemctl restart apache2

apt install -y phpmyadmin

apt-get install -y python-certbot-apache
