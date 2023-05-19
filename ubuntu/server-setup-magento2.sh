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
apt install -y php8.1 php8.1-fpm php8.1-mysql php8.1-dom php8.1-simplexml php8.1-soap php8.1-gd php8.1-iconv php8.1-mbstring php8.1-ctype php8.1-zip php8.1-pdo php8.1-xml php8.1-bcmath php8.1-intl php8.1-curl php8.1-xsl

# Install NGINX
apt install -y nginx

# Install MariaDB
apt install -y mariadb-server

# Configure MariaDB
mysql_secure_installation

# Create a new user for Magento
useradd -m -s /bin/bash magento
passwd magento

# Install Composer globally as root
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Make sure /var/www/html exists and is owned by the magento user
mkdir -p /var/www/html
chown magento:magento /var/www/html

# Download Magento 2.4 as the magento user
# Make sure to replace your Magento marketplace public and private keys
export COMPOSER_AUTH='{"http-basic": {"repo.magento.com": {"username": "<public-key>", "password": "<private-key>"}}}'
sudo -u magento sh -c "cd /var/www/html && COMPOSER_AUTH='$COMPOSER_AUTH' composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition magento"

# Check if Magento installation directory exists
if [ ! -d "/var/www/html/magento" ]; then
  echo "Magento installation directory does not exist. Please check your Magento installation."
  exit 1
fi

# Set proper permissions for Magento
chown -R www-data:www-data /var/www/html/magento
find /var/www/html/magento -type d -exec chmod 770 {} \;
find /var/www/html/magento -type f -exec chmod 660 {} \;
chmod +x /var/www/html/magento/bin/magento

# Create NGINX server block file for Magento only after Magento has been installed
if [ -f /var/www/html/magento/nginx.conf.sample ]; then
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
else
  echo "Cannot find /var/www/html/magento/nginx.conf.sample file. Please check your Magento installation."
  exit 1
fi

# Enable the site
ln -s /etc/nginx/sites-available/magento /etc/nginx/sites-enabled/
systemctl restart nginx

# Print success message
echo "Magento installation successful!"
