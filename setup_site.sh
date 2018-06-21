#!/bin/sh



#This doesn't work, I am too lazy to fix. add to that the fact that I switched to nginx I doubt it will ever be fixed.

echo "Starting Setup."
SITENAME="site.com"
FQDN="www.site.com"
EMAIL="a@b.c"

SITEAVAILABLE = "/etc/apache2/sites-available/" + $SITENAME + ".conf"
SITECONF = $SITENAME + ".conf"

mkdir -p /var/www/$SITENAME/public_html
mkdir -p /var/www/$SITENAME/log

echo "Creating Site Available."
echo "# domain: $SITENAME" > SITEAVAILABLE
echo "<VirtualHost *:80>" >> SITEAVAILABLE
echo "# Admin email, Server Name (domain name), and any aliases" >> SITEAVAILABLE
echo "  ServerAdmin $EMAIL" >> SITEAVAILABLE
echo "  ServerName  $FQDN" >> SITEAVAILABLE
echo "  ServerAlias $SITENAME" >> SITEAVAILABLE
echo " " >> SITEAVAILABLE
echo "  # Index file and Document Root (where the public files are located) " >> SITEAVAILABLE
echo "DirectoryIndex index.html index.php " >> SITEAVAILABLE
echo "  DocumentRoot /var/www/$SITENAME/public_html " >> SITEAVAILABLE
echo "  # Log file locations " >> SITEAVAILABLE
echo "  LogLevel warn " >> SITEAVAILABLE
echo "  ErrorLog  /var/www/$SITENAME/log/error.log" >> SITEAVAILABLE
echo "  CustomLog /var/www/$SITENAME/log/access.log combined " >> SITEAVAILABLE
echo "  <Directory \"/var/www/$SITENAME/public_html\">" >> SITEAVAILABLE
echo "    AllowOverride All" >> SITEAVAILABLE
echo "  </Directory>" >> SITEAVAILABLE
echo "RewriteEngine on" >> SITEAVAILABLE
echo "RewriteCond %{SERVER_NAME} =$FQDN [OR]" >> SITEAVAILABLE
echo "RewriteCond %{SERVER_NAME} =$SITENAME" >> SITEAVAILABLE
echo "RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]" >> SITEAVAILABLE
echo "</VirtualHost>" >> SITEAVAILABLE
echo " " >> SITEAVAILABLE
echo "#done" >> SITEAVAILABLE

a2ensite $SITECONF
apache2 reload

certbot --apache -d $SITENAME -d $FQDN
