yum groupinstall 'Development Tools'
yum -y install ntp httpd24 mod24_ssl mysql-server php54 php54-mysql php54-mbstring phpmyadmin
chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
yum -y install php54 php54-devel php54-gd php54-imap php54-ldap php54-mysql php54-odbc php54-pear php54-xml php54-xmlrpc php54-pecl-apc php54-mbstring php54-mcrypt php54-mssql php54-snmp php54-soap php54-tidy curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel mod24_fcgid php54-cli httpd24-devel
mv /etc/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.bak
#sed -i '95iServerName localhost' /etc/httpd/conf/httpd.conf
#hostname
#read hostn
#ip='127.0.0.1 '
#addhost = ${ip}${hostn}
#echo $addhost >> /etc/hosts
service httpd restart; service mysqld restart
