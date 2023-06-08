#!/bin/bash

## Ask for the new user's username
echo "Enter the username for the new user:"
read username

# Check if the user exists. If not, create the new user
if id "$username" &>/dev/null; then
    echo "User $username already exists"
    else
        echo "Creating new user $username..."
            adduser --gecos "" --disabled-password $username
                echo "User $username has been created"
                fi

## Update system
echo "Updating system..."
apt-get update -y
apt-get upgrade -y
#
## Install UFW
echo "Installing UFW..."
apt-get install ufw -y
#
## Allow SSH through firewall
echo "Configuring UFW..."
ufw allow ssh
#
## Enable UFW
echo "Enabling UFW..."
ufw enable
#
# Install rsyslog
echo "Installing rsyslog..."
apt-get install rsyslog -y

# SSH hardening
echo "Hardening SSH..."
#sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
#sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
echo "You need to uncomment this passspwrd or run the commands after you have confirm your private keys are installed"
# Restart SSH
echo "Restarting SSH..."
systemctl restart ssh

echo "Done!"

