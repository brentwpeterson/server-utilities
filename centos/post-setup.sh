mkdir -p /etc/httpd/vhosts.d/
yum install mutt
yum update
service httpd restart
useradd wagento
echo 'wagento         ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
su wagento
cd ~/
wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo cp ./n98-magerun.phar /usr/local/bin/
sed -i '2ialias magerun="~/./n98-magerun.phar"' ~/.bashrc
exit
