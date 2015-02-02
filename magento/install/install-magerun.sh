cd ~/
wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo cp ./n98-magerun.phar /usr/local/bin/
mkdir -p ~/.n98-magerun/modules/
# Add Fabrizio's Corehacks add on
# https://github.com/AOEpeople/mpmd
git clone https://github.com/AOEpeople/mpmd.git ~/.n98-magerun/modules/mpmd
sed -i '2ialias magerun="~/./n98-magerun.phar"' ~/.bashrc
