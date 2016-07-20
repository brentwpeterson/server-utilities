#########
# This will currently install PHP5.4 and MySQL 5.5 I am working on a new version to install MySQL 5.6
# TODO http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
#########
yum groupinstall 'Development Tools'
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-Server-client-56 Percona-Server-server-56
#yum remove httpd httpd-tools
chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
#install PHP
yum -y install php70w php70w-devel php70w-gd php70w-imap php70w-ldap php70w-mysql php70w-odbc php70w-pear php70w-xml php70w-xmlrpc php70w-pecl-apc php70w-mbstring php70w-mcrypt php70w-snmp php70w-soap php70w-tidy 
yum -y curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel php70w-cli mutt
#Install apache
yum -y install ntp httpd24 mod24_ssl httpd24-tools httpd24-devel
#yum -y install mod24_fcgid 

mv /etc/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.bak
mkdir -p /etc/httpd/vhosts.d
mkdir -p /var/www/vhosts/
sed -i '95iServerName localhost' /etc/httpd/conf/httpd.conf
echo 'IncludeOptional vhosts.d/*.conf' >> /etc/httpd/conf/httpd.conf
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
service httpd restart; service mysqld restart
yum update
service httpd restart; service mysqld restart
cd /home/ec2-user/
wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo cp ./n98-magerun.phar /usr/local/bin/
sed -i '2ialias magerun="~/./n98-magerun.phar"' /home/ec2-user/.bashrc
###################
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html
# TODO need to add/update the amazon permissions
################### 
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} +
find /var/www -type f -exec sudo chmod 0664 {} +
