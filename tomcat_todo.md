Setting up tomcat
=================

First Run setupTomcat.sh

after it finishes 

```Vim /var/lib/tomcat8/conf/tomcat-users.xml```
add befpre closing tag
```
<role rolename="manager-gui"/>
<role rolename="admin-gui"/>
<user username="username" password="password" roles="manager-gui,admin-gui"/>
```
Run

```systemctl restart tomcat8```

and done


PS: If your app is having trouble with memory you may want to alocate more

i.e.
change /etc/default/tomcat7

from
```
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC"
```
 To something like

```
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xms1024m -Xmx1024m -XX:MaxPermSize=512m -XX:+UseConcMarkSweepGC"
```


