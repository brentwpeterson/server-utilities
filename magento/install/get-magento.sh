# #########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
#########################
echo "Enter Magento Version to download, (Default is 1.9.1.0)followed by [ENTER]:"
read version
echo "Do you want to download from a different locaion? The default is ~/ followed by [ENTER]:"
read backdir
backdir=${backdir:-$HOME}
version=${version:-1.9.1.0}
wget http://www.magentocommerce.com/downloads/assets/$version/magento-$version.tar.gz -P $backdir
#####
# TODO : Add this as an option for Sample data
#####
## git clone https://github.com/Vinai/compressed-magento-sample-data.git

