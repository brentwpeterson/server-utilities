#!/bin/bash
# This script will install all required data for a development environment.
# RUN AS USER WAGENTO
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

##
# Creating Database
###
echo "Starting Database creation and DB user"
createDatabase $user $password
