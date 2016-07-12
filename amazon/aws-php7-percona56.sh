#########
# This will currently install PHP5.4 and MySQL 5.5 I am working on a new version to install MySQL 5.6
# TODO http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
#########
yum groupinstall 'Development Tools'
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-Server-client-56 Percona-Server-server-56
#yum remove httpd httpd-tools
yum -y install ntp httpd24 mod24_ssl httpd24-tools 
chkconfig --levels 235 mysqld on
/etc/init.d/mysqld start
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
#install PHP
yum -y install php70w php70w-devel php70w-gd php70w-imap php70w-ldap php70w-mysql php70w-odbc php70w-pear php70w-xml php70w-xmlrpc php70w-pecl-apc php70w-mbstring php70w-mcrypt php70w-snmp php70w-soap php70w-tidy curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel mod24_fcgid php70w-cli httpd24-devel mutt
mv /etc/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.bak
#for future 5.5 use yum install php55-mysqlnd
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
###################
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html
# TODO need to add/update the amazon permissions
################### 
echo "Do you want add a new user to your www directory Leave blank for ec2-user? [ENTER]:"
read newuser
newuser=${newuser:-ec2-user}
groupadd www
usermod -a -G www $newuser
chown -R $newuser:www /var/www
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} +
find /var/www -type f -exec sudo chmod 0664 {} +
sed -i "s/User apache/User "$newuser "/g" /etc/httpd/conf/httpd.conf
sed -i "s/Group apache/Group www/g" /etc/httpd/conf/httpd.conf
