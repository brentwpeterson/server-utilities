#!/bin/bash
#########################
# Ask for the app location
#########################
echo "Enter path for local.xml (Only enter the application path, not the trailing /), followed by [ENTER]:"
read path
find $path/. -type f -exec chmod 644 {} \;
find $path/. -type d -exec chmod 755 {} \;
chmod o+w $path/app/etc
chmod 550 $path/mage
chmod -R o+w $path/var $path/media
