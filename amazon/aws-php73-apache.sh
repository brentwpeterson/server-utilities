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
yum -y install php73 php73-devel php73-gd php73-pdo php73-php-pear php73-mysqlnd php73-imap php73-zip php73-intl php73-bcmath php73-fpm php73-ldap php73-xml php73-xmlrpc php73-curl php73-mbstring php73-mcrypt php73-snmp php73-soap php73-tidy 
yum -y install curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel php73-cli mutt

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e5325b19b381bfd88ce90a5ddb7823406b2a38cff6bb704b0acc289a09c8128d4a8ce2bbafcd1fcbdc38666422fe2806') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

mv composer.phar /usr/local/bin/composer

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
