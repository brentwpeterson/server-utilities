#!/bin/bash
# This script will install all required data for a development environment.
# RUN AS USER WAGENTO
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

    mysql -uroot -proot -e "$SQL"
    #$MYSQL -e "$SQL"
    echo "Database Created" 
}

##
# Create username and set password
##
echo "Enter the username [ENTER]:"
read user
echo "Enter the database name [ENTER]:"
read db

password=$(date +%s | sha256sum | base64 | head -c 10)
##
# Creating Database
###
echo "Starting Database creation and DB user"
createDatabase $user $password $db

echo 'Did you copy the database info somewhere? ' 
echo 'Username: '$user
echo 'Database: '$db
echo 'Password: '$password

echo 'Test Login'
echo "mysql -u"$user "-p'"$password"'" $db > $HOME"/"$user"_"$db".txt"
