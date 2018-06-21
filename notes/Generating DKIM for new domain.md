Generating DKIM for new domain - this gets rid of via phoexer.com in gmail

```
amavisd-new genrsa /var/lib/dkim/new_domain.com.pem 1024
chown amavis:amavis /var/lib/dkim/new_domain.com.pem
chmod 0400 /var/lib/dkim/new_domain.com.pem
```

then get the DKIM with ``` amavisd-new showkeys```
then add this to your new domains DNS

open 
/etc/amavis/conf.d/50-user

locate

dkim_key('mydomain.com', "dkim", "/var/lib/dkim/mydomain.com.pem");

and add

dkim_key('new_domain.com', "dkim", "/var/lib/dkim/new_domain.com.pem"); 

below it


Find below setting in Amavisd config file amavisd.conf:
@dkim_signature_options_bysender_maps = ( {
    ...
    "mydomain.com"  => { d => "mydomain.com", a => 'rsa-sha256', ttl => 10*24*3600 },
    ...
});
Add one line after "mydomain.com" line like below:

@dkim_signature_options_bysender_maps = ( {
    ...
    "mydomain.com"  => { d => "mydomain.com", a => 'rsa-sha256', ttl => 10*24*3600 },
    "new_domain.com"  => { d => "new_domain.com", a => 'rsa-sha256', ttl => 10*24*3600 },
    ...
});
Restart Amavisd service.
Again, don't forget to add DKIM DNS record for this new domain. The value of DKIM record can be checked with command below:

# amavisd-new showkeys
After added DKIM DNS record, please verify it with command:

# amavisd-new testkeys