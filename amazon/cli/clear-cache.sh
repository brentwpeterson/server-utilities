#!/bin/bash
MAGEPATH="/change/to/magento/current"
MAGEUSER="mage_user"
sudo rm -rf $MAGEPATH/var/cache/;
sudo rm -rf $MAGEPATH/var/page_cache/;
sudo chmod -R 755 $MAGEPAGE/var/ $MAGEPATH/pub/;
sudo su - $MAGEUSER -c  'cd $MAGEPATH && bin/magento i:rei' >> $HOME/boot.log
sudo su - $MAGEUSER -c  'cd $MAGEPATH && bin/magento c:c && bin/magento c:f;' >> $HOME/boot.log
#I haven't worked out the details on this yet, but I find it easier to switch back to apache 
sudo chown -R apache:apache $MAGEPATH/var/ $MAGEPATH/pub/;
