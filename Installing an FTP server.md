Installing an FTP server
========================

```
apt-get update
apt-get install vsftpd
```
Do these first because it may give you issues if you don't.
```
listen=YES (default is NO); and
#listen_ipv6=YES (default is uncommented).
allow_writeable_chroot=YES
```

Firewall
```
ufw allow ftp
ufw allow ftps
ufw unable
```
add ftpuser
```adduser ftpuser```


Securing FTP
```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem
```

Config
```
rsa_cert_file=/etc/ssl/private/vsftpd.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.pem
ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
require_ssl_reuse=NO
ssl_ciphers=HIGH
```













