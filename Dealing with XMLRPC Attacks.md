Dealing with XMLRPC Attacks

Every now and then some asshole starts spamming one of my numerous sites sending a ton of POST requests to 
/xmlrpc.php
They are hoping to access a wordpress vulnerability and access the site, the problem is the extra requests swamp my wordpress and can even bring down the database.

The way to solve this is to outright ban the offending ip addresses until such a time as they decide not to bother me.

First Install fail2ban

```
apt-get update && apt-get upgrade -y
apt-get install fail2ban
```

Also make sure your firewall is up and running, if you used the mmusangeya install script then UFW should be up and running just fine.

Next step is to create a new filter to deal with these assholes

File: /etc/fail2ban/filter.d/apache-xmlrpc.conf
```
[Definition]
failregex = ^<HOST> .*POST .*xmlrpc\.php.*
ignoreregex =
```

Next activate the filter by adding the following into either 
/etc/fail2ban/jail.local
or
/etc/fail2ban/jail.conf

```
[apache-xmlrpc]

enabled  = true
port     = http,https
filter   = apache-xmlrpc
logpath  = /var/www/*/log/access.log
maxretry = 10
```

Then finally restart fail2ban
```
service fail2ban restart
```
It should start rejecting those pesky IPs

You can always fine tune the rule and filters e.g. by increasing the jail time, time between attempts etc


To see addresses that are banned you use
```fail2ban-client status apache-xmlrpc```

and to unban an address

```fail2ban-client set apache-xmlrpc unbanip 123.123.123.123```

NB:
There has been some discussion about this method, the problem being that using fail2ban to monitor apache logs can present a performance problem, I won't notice it my self because I'm small but for large sites with lots of traffic this will pose a problem. The way around that issue would be to modify wordpress' xmlrpc.php file such that it logs to a special xmlrpc only file which fail2ban will then monitor. This would reduce the performance hit.

I think I will take it up another time, for now I think I'll chill for a bit


s
