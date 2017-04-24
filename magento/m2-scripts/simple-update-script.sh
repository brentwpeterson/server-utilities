sed -ie 's/2.1.5/2.1.6/g' composer.json 
composer update
chmod u+x bin/magento
./bin/magento set:up
./bin/magento cache:clean
./bin/magento cache:flush

