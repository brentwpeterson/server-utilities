yum groupinstall 'Development Tools'
um -y install mariadb-server mariadb
yum -y install ntp httpd mod_ssl php php-mysql php-mbstring phpmyadmin
chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
yum -y install php php-devel php-gd php-imap php-ldap php-mysql php-odbc php-pear php-xml php-xmlrpc php-pecl-apc php-mbstring php-mcrypt php-mssql php-snmp php-soap php-tidy curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel mod24_fcgid php-cli httpd-devel
yum install php-igbinary
yum intsall memcached redis
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/epel-release-7.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7*.rpm epel-release-7*.rpm
yum update
yum install php-mcrypt*
mv /etc/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.bak
sed -i '95iServerName localhost' /etc/httpd/conf/httpd.conf
mkdir -p /etc/httpd/vhosts.d/
yum install mutt
read -p "Install Firewall? [yn]" answer
if [ $answer == y ]; then
yum install system-config-firewall
fi
service httpd restart; service mysqld restart
yum update
service httpd restart; service mysqld restart
