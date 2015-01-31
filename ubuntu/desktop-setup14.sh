apt-get install ssh openssh-server vim-nox vim ntp ntpdate
apt-get install mysql-client-5.6 mysql-server-5.6 openssl binutils sudo
apt-get install apache2 
apt-get install apache2.2-common apache2-doc apache2-mpm-prefork apache2-utils libexpat1 ssl-cert libapache2-mod-php5 php5 php5-common php5-gd php5-mysql php5-imap php5-cgi libapache2-mod-fcgid apache2-suexec php-pear php-auth php5-curl php5-mcrypt mcrypt php5-imagick imagemagick libapache2-mod-suphp libruby libapache2-mod-ruby libapache2-mod-python libapache2-mod-perl2
a2enmod rewrite ssl actions include
/etc/init.d/apache2 restart
apt-get install php5-xcache php5-cli
/etc/init.d/apache2 restart
apt-get install libapache2-mod-fastcgi php5-fpm
a2enmod actions fastcgi alias
/etc/init.d/apache2 restart
sudo apt-get install default-jre
sudo apt-get install default-jdk
apt-get update
