FROM centos:6.7

RUN yum -y update && yum clean all 
RUN yum -y install tar httpd perl perl-CGI && yum clean all
COPY TWiki20040903.tar.gz /tmp/
RUN mkdir /var/www/html/wiki && tar -xvf /tmp/TWiki20040903.tar.gz -C /var/www/html/wiki/ --strip 1
RUN sed -i 's|!FILE_path_to_TWiki!|/var/www/html/wiki|g' /var/www/html/wiki/bin/.htaccess.txt \
    && sed -i 's|!URL_path_to_TWiki!||g' /var/www/html/wiki/bin/.htaccess.txt
RUN mv /var/www/html/wiki/bin/.htaccess.txt /var/www/html/wiki/bin/.htaccess
RUN sed -i "s|$twikiLibPath = '../lib';|$twikiLibPath = '/var/www/html/wiki/lib';|g" /var/www/html/wiki/bin/setlib.cfg \
    && sed -i "s|/home/httpd/twiki|/var/www/html/wiki|g" /var/www/html/wiki/lib/TWiki.cfg \ 
    && sed -i "s|http://your.domain.com|http://twiki|g" /var/www/html/wiki/lib/TWiki.cfg \
    && sed -i "s|/twiki/bin|/bin|g" /var/www/html/wiki/lib/TWiki.cfg \
    && sed -i "s|/twiki/pub|/pub|g" /var/www/html/wiki/lib/TWiki.cfg \
    && sed -i "s|gmtime|servertime|g" /var/www/html/wiki/lib/TWiki.cfg \
    && sed -i "s|$doRememberRemoteUser = \"0\";|$doRememberRemoteUser = \"1\";|g" /var/www/html/wiki/lib/TWiki.cfg \
    && chown -R apache:apache /var/www/html/wiki \
    && chmod -R go-rwx /var/www/html/wiki \
    && chmod 500 /var/www/html/wiki/templates
    
    
COPY httpd.conf /etc/httpd/conf/

EXPOSE 80
#CMD /bin/bash
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]