#########
# This will currently install PHP5.4 and MySQL 5.5 I am working on a new version to install MySQL 5.6
# TODO http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
#########
yum groupinstall 'Development Tools'
yum -y install ntp httpd24 mod24_ssl mysql-server php54 php54-mysql php54-mbstring phpmyadmin
chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
yum -y install php54 php54-devel php54-gd php54-imap php54-ldap php54-mysql php54-odbc php54-pear php54-xml php54-xmlrpc php54-pecl-apc php54-mbstring php54-mcrypt php54-mssql php54-snmp php54-soap php54-tidy curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel mod24_fcgid php54-cli httpd24-devel mutt
mv /etc/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.bak
mkdir -p /etc/httpd/vhosts.d
mkdir -p /var/www/vhosts/
sed -i '95iServerName localhost' /etc/httpd/conf/httpd.conf
echo 'IncludeOptional vhosts.d/*.conf' >> /etc/httpd/conf/httpd.conf
#hostname
#read hostn
#ip='127.0.0.1 '
#addhost = ${ip}${hostn}
#echo $addhost >> /etc/hosts
service httpd restart; service mysqld restart
yum update
service httpd restart; service mysqld restart
cd /home/ec2-user/
wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo cp ./n98-magerun.phar /usr/local/bin/
sed -i '2ialias magerun="~/./n98-magerun.phar"' /home/ec2-user/.bashrc

