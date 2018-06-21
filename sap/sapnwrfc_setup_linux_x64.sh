#!/bin/sh

echo "Installing SAP NW RFC Extention for PHP7.x"

echo "Create sap folder and get our repos"
mkdir -p /usr/sap
git clone https://github.com/phoexer/SAPNWRFC_LINUX_X64.git /usr/sap/nwrfcsdk
git clone https://github.com/phoexer/php7-sapnwrfc.git /usr/sap/php7-sapnwrfc

echo "Add sdk to path"
echo "/usr/sap/nwrfcsdk/lib" > /etc/ld.so.conf.d/nwrfcsdk.conf
ldconfig

 
echo "Lets get to compiling"
cd /usr/sap/php7-sapnwrfc

echo "honectly I hope you ran the lamp setup script, cuz this will hurt otherwise."

phpize

./configure

make

make install

echo "For some reason when I did for 7.1 it created the 7.2 folder as well and wouldn't activate mod untill ini file was there too."
for file in /etc/php/7.*/ ; do
    echo "; configuration for php common module" > "$file/mods-available/sapnwrfc.ini";
    echo "; priority=20" >> "$file/mods-available/sapnwrfc.ini";
    echo "extension=sapnwrfc.so" >> "$file/mods-available/sapnwrfc.ini";
done

echo "enable mod"
phpenmod sapnwrfc

echo "create test php /var/www/html/testSAP.php"
echo "You need to edit this file to add your details"

echo "<?php" > /var/www/html/testSAP.php
echo "use SAPNWRFC\Connection as SapConnection;use SAPNWRFC\Exception as SapException;echo '<h1>SAPNWRFC Test</h1>';" >> /var/www/html/testSAP.php
echo "" >> /var/www/html/testSAP.php
echo "/**" >> /var/www/html/testSAP.php
echo "* Please add your sap settings here" >> /var/www/html/testSAP.php
echo "**/" >> /var/www/html/testSAP.php
echo "\$parameters = [" >> /var/www/html/testSAP.php
echo "    'ashost' => '', //Hostname or address" >> /var/www/html/testSAP.php
echo "    'sysnr'  => '', // System Number" >> /var/www/html/testSAP.php
echo "    'client' => '', //Client Number" >> /var/www/html/testSAP.php
echo "    'user' => '', //User Name" >> /var/www/html/testSAP.php
echo "    'passwd' => '',  //Password" >> /var/www/html/testSAP.php
echo "    //'SAPROUTER' => '', //Router String" >> /var/www/html/testSAP.php
echo "];" >> /var/www/html/testSAP.php
echo " try { \$connection = new SapConnection(\$parameters); \$remoteFunction = \$connection->getFunction('Z_MIM_TEST'); echo '<h3>Input Variables</h3>'; \$input = [ 'INP' => 'Freedom' ]; var_dump(\$input); \$result = \$remoteFunction->invoke(\$input); echo '<h3>Return Values</h3>'; var_dump(\$result); \$connection->close(); } catch(SapException \$ex) { echo 'Exception: ' . \$ex->getMessage() . PHP_EOL; }" >> /var/www/html/testSAP.php


echo "restart apache and ..."
service apache2 restart

echo "we're done."