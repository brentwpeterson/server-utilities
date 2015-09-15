yum groupinstall 'Development Tools'
yum -y install ntp httpd24 mod_ssl httpd24-devel
chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
yum -y install  php55-mysql php55-mbstring php55 php55-devel php55-gd php55-imap php55-ldap php55-pear php55-xml php55-xmlrpc php55-pecl-apc php55-mcrypt php55-soap php55-tidy curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel mod24_fcgid php55-cli
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
