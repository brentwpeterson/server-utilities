yum groupinstall 'Development Tools'
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-Server-client-56 Percona-Server-server-56
yum -y install ntp httpd mod_ssl php php-mysql php-mbstring phpmyadmin
chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
yum -y install php php-devel php-gd php-imap php-ldap php-mysql php-odbc php-pear php-xml php-xmlrpc php-pecl-apc php-mbstring php-mcrypt php-mssql php-snmp php-soap php-tidy curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel mod24_fcgid php-cli httpd-devel
yum install php-igbinary
yum intsall memcached redis
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
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
#hostname
#read hostn
#ip='127.0.0.1 '
#addhost = ${ip}${hostn}
#echo $addhost >> /etc/hosts
service httpd restart; service mysqld restart
yum update
service httpd restart; service mysqld restart
useradd wagento
echo 'wagento         ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
su wagento
cd ~/ 
wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo cp ./n98-magerun.phar /usr/local/bin/
sed -i '2ialias magerun="~/./n98-magerun.phar"' ~/.bashrc
exit
