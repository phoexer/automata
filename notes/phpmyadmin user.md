MySQL 5.7 changed the secure model: now MySQL root login requires a sudo.

I.e., phpMyAdmin will be not able to use root credentials.

The simplest (and safest) solution will be create a new user and grant required privileges.

1. Connect to mysql
# mysql -u root
2. Create a user for phpMyAdmin
Run the following commands (replacing some_pass by the desired password):

CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY 'some_pass';
GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
If your phpMyAdmin is connecting to localhost, this should be enough.

3. Optional: allow remote connections
Remember: allow a remote user to have all privileges is a security concern.

With this in mind, if you want this user to have the same privileges during remote connections, additionally run (replacing some_pass by the password used in Step #2):

CREATE USER 'phpmyadmin'@'%' IDENTIFIED BY 'some_pass';
GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
4. Update phpMyAdmin
Using sudo, edit /etc/dbconfig-common/phpmyadmin.conf file updating user/password values in the following sections (replacing some_pass by the password used in Step #2):

# dbc_dbuser: database user
#       the name of the user who we will use to connect to the database.
dbc_dbuser='phpmyadmin'

# dbc_dbpass: database user password
#       the password to use with the above username when connecting
#       to a database, if one is required
dbc_dbpass='some_pass'