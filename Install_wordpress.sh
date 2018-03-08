#!/bin/sh

echo "Starting Setup."
SITENAME=""

cd /var/www/$SITENAME/public_html

wget http://wordpress.org/latest.tar.gz

tar xzvf latest.tar.gz

rm latest.tar.gz

mv ./wordpress/* ./

rm -rf wordpress/

chown -R www-data: /var/www/
