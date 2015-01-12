sudo yum install git-core
git clone https://github.com/brentwpeterson/server-utilities.git
wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo cp ./n98-magerun.phar /usr/local/bin/
sed -i '2ialias magerun="~/./n98-magerun.phar"' /home/ec2-user/.bashrc
ssh-keygen -t rsa
sudo yum update 
