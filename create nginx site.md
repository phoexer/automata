Creating an nginx site 
======================

First go to ```/etc/nginx/sites-available``` and create a new file there.
I name them ```site.com.conf```

In this site paste the following
```
server {
    listen 80;
    listen [::]:80;

    root /var/www/site.com/public_html;
    index index.php index.html index.htm index.nginx-debian.html;

    server_name site.com www.site.com;
}
```

To enable the site 
```
ln -s /etc/nginx/sites-available/site.com.conf /etc/nginx/sites-enabled/
service nginx restart
```

Run your certbot and after it runs edit the file to place

```
try_files $uri $uri/ /index.php?q=$uri&$args;
include /etc/nginx/templates/php-catchall.tmpl;
```

after the certbot stuff.

listen [::]:443 ssl; # managed by Certbot
listen 443 ssl; # managed by Certbot
ssl_certificate /etc/letsencrypt/live/mmusangeya.com/fullchain.pem; # managed by Certbot
ssl_certificate_key /etc/letsencrypt/live/mmusangeya.com/privkey.pem; # managed by Certbot
include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


