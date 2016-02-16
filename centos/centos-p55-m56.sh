yum groupinstall 'Development Tools'
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
#Need to work on getting Apache 2.4 into this
yum -y install ntp httpd mod_ssl httpd-devel
#install Percona
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-Server-server-56
yum -y install  php55w-mysql php55w-mbstring php55w php55w-devel php55w-gd php55w-imap php55w-ldap php55w-pear php55w-xml php55w-xmlrpc php55w-pecl-apc php55w-mcrypt php55w-soap php55w-tidy curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel mod24_fcgid php55w-cli
#yum install php55w-igbinary
yum install redis
#wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
#rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm
yum update
#yum install php-mcrypt*
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
mv /etc/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.bak
sed -i '95iServerName localhost' /etc/httpd/conf/httpd.conf
mkdir -p /etc/httpd/vhosts.d/
yum install mutt
read -p "Install Firewall? [yn]" answer
if [ $answer == y ]; then
yum install system-config-firewall
fi
chkconfig --levels 235 mysql on
/etc/init.d/mysql start
service httpd restart; service mysql restart
yum update
service httpd restart; service mysql restart
useradd wagento
echo 'wagento         ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
su wagento
cd ~/ 
wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo cp ./n98-magerun.phar /usr/local/bin/
sed -i '2ialias magerun="~/./n98-magerun.phar"' ~/.bashrc
exit
