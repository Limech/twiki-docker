#!/bin/bash

sed -i 's|!FILE_path_to_TWiki!|/var/www/html/wiki|g' ${wikiPath}/bin/.htaccess.txt 
sed -i 's|!URL_path_to_TWiki!||g' /var/www/html/wiki/bin/.htaccess.txt
mv /var/www/html/wiki/bin/.htaccess.txt /var/www/html/wiki/bin/.htaccess
sed -i "s|$twikiLibPath = '../lib';|$twikiLibPath = '/var/www/html/wiki/lib';|g" ${wikiPath}/bin/setlib.cfg 
sed -i "s|/home/httpd/twiki|/var/www/html/wiki|g" ${wikiPath}/lib/TWiki.cfg 
sed -i "s|http://your.domain.com|http://twiki|g" ${wikiPath}/lib/TWiki.cfg 
sed -i "s|/twiki/bin|/bin|g" ${wikiPath}/lib/TWiki.cfg 
sed -i "s|/twiki/pub|/pub|g" ${wikiPath}/lib/TWiki.cfg 
sed -i "s|gmtime|servertime|g" ${wikiPath}/lib/TWiki.cfg 
sed -i "s|$doRememberRemoteUser = \"0\";|$doRememberRemoteUser = \"1\";|g" ${wikiPath}/lib/TWiki.cfg 
chown -R apache:apache ${wikiPath} 
chmod -R go-rwx ${wikiPath} 
chmod 500 ${wikiPath}/templates