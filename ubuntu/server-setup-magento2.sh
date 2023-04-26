#!/bin/bash

# Update system
apt-get update
apt-get upgrade -y

# Install necessary tools
apt-get install -y software-properties-common wget curl unzip

# Add repository for PHP 8
add-apt-repository ppa:ondrej/php -y
apt-get update

# Install NGINX, PHP 8 and required PHP extensions for Magento 2.4
apt-get install -y nginx php8.0 php8.0-fpm php8.0-mysql php8.0-dom php8.0-simplexml php8.0-xml php8.0-curl php8.0-xsl php8.0-gd php8.0-xmlreader php8.0-mbstring php8.0-intl php8.0-iconv php8.0-zip php8.0-soap php8.0-sockets php8.0-bcmath

# Install MariaDB
apt-get install -y mariadb-server mariadb-client

# Start and enable services
systemctl start nginx
systemctl enable nginx
systemctl start php8.0-fpm
systemctl enable php8.0-fpm
systemctl start mariadb
systemctl enable mariadb

# Configure MariaDB
mysql_secure_installation

# Create Magento database and user
mysql -u root -p -e "CREATE DATABASE magento_db; CREATE USER 'magento_user'@'localhost' IDENTIFIED BY 'your_magento_user_password'; GRANT ALL PRIVILEGES ON magento_db.* TO 'magento_user'@'localhost'; FLUSH PRIVILEGES;"

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# Download Magento 2.4
wget https://github.com/magento/magento2/archive/2.4.zip
unzip 2.4.zip
mv magento2-2.4 /var/www/html/magento

# Set permissions for Magento
chown -R www-data:www-data /var/www/html/magento
chmod -R 755 /var/www/html/magento

# Create NGINX site configuration for Magento
cat > /etc/nginx/sites-available/magento << EOL
upstream fastcgi_backend {
    server unix:/run/php/php8.0-fpm.sock;
}

server {
    listen 80;
    server_name yourdomain.com;
    set \$MAGE_ROOT /var/www/html/magento;
    set \$MAGE_MODE developer;
    include /var/www/html/magento/nginx.conf.sample;
}
EOL

# Enable the Magento site
ln -s /etc/nginx/sites-available/magento /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default
systemctl restart nginx

# Install Magento 2.4 using Composer
cd /var/www/html/magento
composer install

# Run Magento installation
bin/magento setup:install --base-url=http://yourdomain.com/ \
--db-host=localhost \
--db-name=magento_db \
--db-user=magento_user \
--db-password=your_magento_user_password \
--admin-firstname=Admin \
--admin-lastname=User \
--admin-email=admin@example.com \
--admin-user=admin \
--admin-password=admin123 \
--language=en_US \
--currency=USD
