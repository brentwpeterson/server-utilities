function createDatabase ()
{

	    MYSQL=`which mysql`

	        Q1="CREATE DATABASE IF NOT EXISTS $3;"
		Q2="CREATE USER '$1'@'localhost' IDENTIFIED BY '$2';"
	   	Q3="GRANT USAGE on $3.* to '$1'@'localhost' IDENTIFIED BY '$2';"
		Q4="GRANT ALL PRIVILEGES ON $3.* TO '$1'@'localhost' IDENTIFIED BY '$2';"
		Q5="FLUSH PRIVILEGES;"
		SQL="${Q1}${Q2}${Q3}${Q4}${Q5}"
		echo $SQL

		mysql -uroot -e "$SQL"
		$MYSQL -e "$SQL"
		echo "Database Created" 
}

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
yum update
chkconfig --levels 235 php-fpm on
/etc/init.d/php-fpm start
#TODO /etc/sysconfig/varnish
#yum install varnish
#Now find VARNISH_LISTEN_PORT=6081 and change it to port 80, save and close.
# https://github.com/PHOENIX-MEDIA/Magento-PageCache-powered-by-Varnish.git

#We will leave the groups as nginx:nginx for the demo server
#echo "Do you want add a new user to your www directory Leave blank for ec2-user? [ENTER]:"
#read newuser
#newuser=${newuser:-ec2-user}
#groupadd www
#usermod -a -G www $newuser
mkdir -p /var/www/vhosts/demo/html
chown -R nginx:nginx /var/www/vhosts/demo/html
cd /var/www/vhosts/demo/
ln -s /var/www/vhosts/demo/html current
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} +
find /var/www -type f -exec sudo chmod 0664 {} +
#Create Database
password=$(date +%s | sha256sum | base64 | head -c 10)
echo "Starting Database creation and DB user"
createDatabase 'demo' $password 'demo'
echo 'Did you copy the database info somewhere? ' 
echo 'Username: '$user
echo 'Database: '$db
echo 'Password: '$password
echo 'Test Login'
echo "mysql -u"$user "-p'"$password"'" $db > $HOME"/"$user"_"$db".txt"

sed -e "s;%USER%;demo;" $HOME/server-scripts/amazon/base-nginx.conf > '/etc/nginx/conf.d/demo.conf'
