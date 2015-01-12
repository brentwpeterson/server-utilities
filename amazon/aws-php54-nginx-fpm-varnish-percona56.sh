#########
#https://www.ashsmith.io/2012/12/creating-a-faster-magento-store-part-one-server-setup/
#########
yum groupinstall 'Development Tools'
yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm
yum install Percona-Server-client-56 Percona-Server-server-56
yum -y install ntp nginx 
chkconfig --levels 235 mysql on
/etc/init.d/mysql start
chkconfig --levels 235 nginx on
/etc/init.d/nginx start
mkdir -p /var/www/vhosts/
yum install php54-fpm php54-mysqlnd php54-pdo php54-common php54-mcrypt php54-gd php54-curl php54-soap
#TODO open up php.ini, find cgi.fix_pathinfo and set the value to 0
#sed -i '95iServerName localhost' /etc/httpd/conf/httpd.conf
#echo 'IncludeOptional vhosts.d/*.conf' >> /etc/httpd/conf/httpd.conf
#hostname
#read hostn
#ip='127.0.0.1 '
#addhost = ${ip}${hostn}
#echo $addhost >> /etc/hosts
yum update
chkconfig --levels 235 php-fpm on
/etc/init.d/php-fpm start
yum install varnish
#TODO /etc/sysconfig/varnish
#Now find VARNISH_LISTEN_PORT=6081 and change it to port 80, save and close.
# https://github.com/PHOENIX-MEDIA/Magento-PageCache-powered-by-Varnish.git

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
#sed -i "s/User apache/User "$newuser "/g" /etc/httpd/conf/httpd.conf
#sed -i "s/Group apache/Group www/g" /etc/httpd/conf/httpd.conf
