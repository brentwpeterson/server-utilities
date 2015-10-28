# #########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
#########################
cd ~/
wget https://raw.githubusercontent.com/netz98/n98-magerun/master/n98-magerun.phar
chmod +x ./n98-magerun.phar
sudo cp ./n98-magerun.phar /usr/local/bin/
mkdir -p ~/.n98-magerun/modules/
# Add Fabrizio's Corehacks add on
# https://github.com/AOEpeople/mpmd
git clone https://github.com/AOEpeople/mpmd.git ~/.n98-magerun/modules/mpmd
sed -i '2ialias magerun="~/./n98-magerun.phar"' ~/.bashrc

# source .bashrc to your current terminal instance
source  ~/.bashrc

mkdir -p ~/.n98-magerun/modules/

cd ~/.n98-magerun/modules/ &&  git clone https://github.com/brentwpeterson/magerun-addons-1.git
cd ~/.n98-magerun/modules/ &&  git clone https://github.com/brentwpeterson/magerun-addons.git
