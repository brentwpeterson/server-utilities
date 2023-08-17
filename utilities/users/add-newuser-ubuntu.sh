#!/bin/bash

# Prompt for the username
read -p "Please enter the username: " USERNAME

# Generate a random password for the new user with OpenSSL and assign it to a variable
PASSWORD=$(openssl rand -base64 14)

echo -e "\nCreating user $USERNAME..."

# Create the new user with useradd command
sudo useradd -m -s /bin/bash $USERNAME

echo -e "Setting password for the new user $USERNAME..."

# Set the password for the new user
echo "$USERNAME:$PASSWORD" | sudo chpasswd

echo -e "\nUser $USERNAME has been created.\nPlease copy the below user credentials:\nUsername: $USERNAME\nPassword: $PASSWORD\nProceed to the next step..."

# Ask if the new user should be added to the sudo group
read -p "Should the user be added to the sudo group? (yes/no): " SUDO_OPTION
if [ $SUDO_OPTION == "yes" ]
then
    sudo usermod -aG sudo $USERNAME
    echo "$USERNAME is added to the sudo group."
else
    echo "$USERNAME is not added to the sudo group."
fi

# Create .ssh directory and set the right permissions
sudo mkdir /home/$USERNAME/.ssh
sudo chmod 700 /home/$USERNAME/.ssh

# Create authorized_keys file and set the right permissions
sudo touch /home/$USERNAME/.ssh/authorized_keys
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys

# Prompt to add public key
read -p "Do you want to add a public key for the new user? (yes/no): " KEY_OPTION
if [ $KEY_OPTION == "yes" ]
then
    read -p "Please paste the public key: " PUBLIC_KEY
    echo "$PUBLIC_KEY" | sudo tee -a /home/$USERNAME/.ssh/authorized_keys
fi

# Change the owner of .ssh directory and authorized_keys file to the new user
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh

echo -e "\nUser $USERNAME has been created.\nPlease copy the below user credentials:\nUsername: $USERNAME\nPassword: $PASSWORD\nYou can now add your public key to /home/$USERNAME/.ssh/authorized_keys."
