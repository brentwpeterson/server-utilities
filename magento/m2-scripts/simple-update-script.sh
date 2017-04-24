#replace with the from and to versions
sed -ie 's/2.1.5/2.1.6/g' composer.json 
#run composer update
composer update
#comfirm that magento is executable
chmod u+x bin/magento
#run magento setup
./bin/magento set:up
#clear cache
./bin/magento cache:clean
./bin/magento cache:flush
./bin/magento --version

