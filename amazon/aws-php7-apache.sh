#########
# PHP7 / Apache / Varnish / Magerun
#########
yum groupinstall 'Development Tools'
#Install apache
yum -y install ntp httpd24 mod24_ssl httpd24-tools httpd24-devel
yum -y install mod24_fcgid 
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
mv /etc/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.bak
mkdir -p /etc/httpd/vhosts.d
sed -i '95iServerName localhost' /etc/httpd/conf/httpd.conf
echo 'IncludeOptional vhosts.d/*.conf' >> /etc/httpd/conf/httpd.conf
sudo rpm -Uvh http://mirrors.mediatemple.net/remi/enterprise/remi-release-6.rpm

#install PHP
yum --enablerepo=epel install scl-utils
yum -y install php70 php70-devel php70-gd php70-pdo php70-php-pear php70-mysqlnd php70-imap php70-zip php70-intl php70-fpm php70-ldap php70-xml php70-xmlrpc php70-curl php70-mbstring php70-mcrypt php70-snmp php70-soap php70-tidy 
yum -y install curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel php70-cli mutt

cd ~/
wget https://files.magerun.net/n98-magerun2.phar
chmod +x ./n98-magerun2.phar
sed -i '2ialias magerun2="~/./n98-magerun2.phar"' ~/.bashrc

# source .bashrc to your current terminal instance
source ~/.bashrc
sudo cp ./n98-magerun2.phar /usr/local/bin/
###################
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html
# TODO need to add/update the amazon permissions
################### 
mkdir -p /var/www/vhosts/
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} +
find /var/www -type f -exec sudo chmod 0664 {} +
