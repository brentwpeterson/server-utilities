#!/bin/bash
##
# Create username and set password
##
echo "Enter the username, followed by [ENTER]:"
read user
echo "Enter the password for the account created, followed by [ENTER]:"
read password
echo "Adding user"
useradd $user
echo $password | passwd $user --stdin

##
# Create required directories
##
echo "Creating Needed Directories"
cd /home/$user
chmod 755 /home/$user
mkdir -p /var/www/vhosts/$user/html
mkdir -p /var/www/vhosts/$user/logs
mkdir -p /var/www/vhosts/$user/mysql_backup
chown -R $user:$user /var/www/vhosts/$user/
#
# Create apache conf
##
echo "Creating Apache Configuration"
sed -e "s;%USER%;$user;" /root/server-scripts/centos/base.conf > '/etc/httpd/vhosts.d/'$user'.conf'
echo "Restarting Apache Gracefully"
service httpd graceful

##
# create SSH keys
##
echo "Creating RSA Keys"
mkdir /home/$user/.ssh
chmod 777 /home/$user/.ssh
su $user -c "ssh-keygen -t rsa -f /home/$user/.ssh/id_rsa"
chmod 700 /home/$user/.ssh
chown -R $user:$user /home/$user
##
# Send email with id.rsa.pub attached
##
echo "This is the message body" | mutt -s "Development Information" -a "/home/$user/.ssh/id_rsa.pub" -- brent@wagento.com

##
# return to root directory
##
#cd ~
#echo "Copy and paste key to codebase"
#su $user -c "cat ~/.ssh/id_rsa.pub"
#echo "Enter GIT Repo adddress, followed by [ENTER]:"
#read gitrepo
#cd /var/www/vhosts/$user/html
#su $user -c "git clone $gitrepo ."
#su $user -c "mkdir var"
#su $user -c "mkdir media"
#su $user -c "chmod -R o+w media var app/etc"
#su wagento -c "magerun local-config:generate 'localhost' $user $pass $user 'files' 'admin'"
