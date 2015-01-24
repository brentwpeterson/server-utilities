echo "Do you want add a new user to your www directory Leave blank for ec2-user? [ENTER]:"
read newuser
newuser=${newuser:-ec2-user}
groupadd www
usermod -a -G www $newuser
chown -R $newuser:www /var/www
chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} +
find /var/www -type f -exec sudo chmod 0664 {} +
