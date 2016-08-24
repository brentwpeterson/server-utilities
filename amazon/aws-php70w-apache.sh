#########
# TODO 
#########
yum groupinstall 'Development Tools'
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

sed -i '15iexclude=httpd-tools* httpd*' /etc/yum.repos.d/amzn-main.repo 
yum -y install ntp httpd24 mod24_ssl httpd24-tools httpd24-devel
yum -y install mod24_fcgid 
chkconfig --levels 235 httpd on
/etc/init.d/httpd start
mv /etc/httpd/conf.d/fcgid.conf /etc/httpd/conf.d/fcgid.bak
sed -i '95iServerName localhost' /etc/httpd/conf/httpd.conf
echo 'IncludeOptional vhosts.d/*.conf' >> /etc/httpd/conf/httpd.conf
/etc/init.d/httpd restart
#install PHP
yum -y install php70w php70w-devel php70w-gd php70w-imap php70w-fpm php70w-ldap php70w-mysql php70w-pear php70w-xml php70w-xmlrpc php70w-curl php70w-mbstring php70w-mcrypt php70w-snmp php70w-soap php70w-tidy 
yum -y install curl curl-devel perl-libwww-perl ImageMagick libxml2 libxml2-devel php70w-cli mutt

yum update

cd /home/ec2-user/
wget https://files.magerun.net/n98-magerun2.phar
chmod +x ./n98-magerun2.phar
sed -i '2ialias magerun2="~/./n98-magerun2.phar"' ~/.bashrc
sudo cp ./n98-magerun2.phar /usr/local/bin/
source  ~/.bashrc

###################
# http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-LAMP.html
# TODO need to add/update the amazon permissions
################### 
mkdir -p /var/www/vhosts/
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} +
find /var/www -type f -exec sudo chmod 0664 {} +
mkdir -p /etc/httpd/vhosts.d
