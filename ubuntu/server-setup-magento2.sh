#!/bin/bash
set -e

# Ensure the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root" >&2
  exit 1
fi

# Update package index
apt update

# Install required packages
apt install -y software-properties-common wget

# Add repository for PHP 8.1
add-apt-repository -y ppa:ondrej/php
apt update

# Install PHP 8.1 and required extensions
apt install -y php8.1 php8.1-fpm php8.1-mysql php8.1-dom php8.1-simplexml php8.1-soap php8.1-gd php8.1-iconv php8.1-mbstring php8.1-ctype php8.1-zip php8.1-pdo php8.1-xml php8.1-bcmath php8.1-json php8.1-intl php8.1-curl php8.1-xsl

# Install NGINX
apt install -y nginx

# Install MariaDB
apt install -y mariadb-server

# Configure MariaDB
mysql_secure_installation

# Install Composer
apt install -y composer

# Create NGINX server block file for Magento
cat > /etc/nginx/sites-available/magento <<EOL
upstream fastcgi_backend {
  server  unix:/run/php/php8.1-fpm.sock;
}

server {
  listen 80;
  server_name example.com;
  set \$MAGE_ROOT /var/www/html/magento;
  include /var/www/html/magento/nginx.conf.sample;
}
EOL

# Enable the NGINX server block
ln -s /etc/nginx/sites-available/magento /etc/nginx/sites-enabled/

# Disable the default NGINX server block
rm /etc/nginx/sites-enabled/default

# Restart NGINX and PHP-FPM services
systemctl restart nginx
systemctl restart php8.1-fpm

#UnComment if you want to install Magewnto
# Download Magento 2.4
# cd /var/www/html
# composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition magento

# Set proper permissions for Magento
# chown -R www-data:www-data /var/www/html/magento
# find /var/www/html/magento -type d -exec chmod 770 {} \;
# find /var/www/html/magento -type f -exec chmod 660 {} \;
# chmod +x /var/www/html/magento/bin/magento

# echo "Magento installation completed. Please proceed with the browser-based installation."
