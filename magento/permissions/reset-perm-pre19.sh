#!/bin/bash
#########################
# Ask for the app location
#########################

find $1/. -type f -exec chmod 644 {} \;
find $1/. -type d -exec chmod 755 {} \;
chmod o+w $1/app/etc
chmod 550 $1/mage
chmod -R o+w $path/var $1/media
