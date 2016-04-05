# #########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
#########################
cd ~/
wget https://files.magerun.net/n98-magerun2.phar
chmod +x ./n98-magerun2.phar
sed -i '2ialias magerun2="~/./n98-magerun2.phar"' ~/.bashrc

# source .bashrc to your current terminal instance
source  ~/.bashrc
cp ./n98-magerun2.phar /usr/local/bin/
