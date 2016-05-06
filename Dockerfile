FROM centos:6.7

# Environment variables
## This one still requires you to change the value in a few places below
## since environment variables can't be inserted into 'sed' commands.
ENV wikiPath /var/www/html/wiki  

# Install requirements
RUN yum -y update && yum clean all 
RUN yum -y install tar httpd perl perl-CGI && yum clean all
COPY httpd.conf /etc/httpd/conf/

# Copy and configure Twiki framework under /var/www/html/wiki
COPY TWiki20040904.tar.gz /tmp/
RUN mkdir ${wikiPath} && tar -xvf /tmp/TWiki20040904.tar.gz -C ${wikiPath}/ --strip 1
COPY configTwiki.sh  ${wikiPath}/
RUN /bin/bash -c 'source ${wikiPath}/configTwiki.sh'

EXPOSE 80

#CMD /bin/bash
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# && CMD["tail -f /dev/null]