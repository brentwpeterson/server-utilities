#!/bin/bash
# This script will install all required data for a development environment.
#Run with SUDO?
function createDatabase ()
{
    
    MYSQL=`which mysql`

    Q1="CREATE DATABASE IF NOT EXISTS $1;"
    Q2="CREATE USER '$1'@'localhost' IDENTIFIED BY '$2';"
    Q3="GRANT USAGE on *.* to '$1'@'localhost' IDENTIFIED BY '$2';"
    Q4="GRANT ALL PRIVILEGES ON $1.* TO '$1'@'localhost' IDENTIFIED BY '$2';"
    Q5="FLUSH PRIVILEGES;"
    SQL="${Q1}${Q2}${Q3}${Q4}${Q5}"
    
    echo $SQL

    mysql -uroot -e "$SQL"
    $MYSQL -e "$SQL"
    echo "Database Created" 
}

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
sed -e "s;%USER%;$user;" /home/ec2-user/server-scripts/amazon/base.conf > '/etc/httpd/vhosts.d/'$user'.conf'
echo "Restarting Apache Gracefully"
service httpd graceful

##
# Creating Database
###
echo "Starting Database creation and DB user"
createDatabase $user $password

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
cd ~
echo "Copy and paste key to codebase"
su $user -c "cat ~/.ssh/id_rsa.pub"
read -p "Do you want to setup a repo now?" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "Enter GIT Repo adddress, followed by [ENTER]:"
read gitrepo
cd /var/www/vhosts/$user/html
su $user -c "git clone $gitrepo ."
su $user -c "mkdir var"
su $user -c "mkdir media"
su $user -c "chmod -R o+w media var app/etc"
fi
