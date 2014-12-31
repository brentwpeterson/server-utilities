#!/bin/bash
#########################
# Ask for the app location
# this is from http://www.magentocommerce.com/knowledge-base/entry/install-privs-after
#########################
echo "Enter the application path, not the trailing /), followed by [ENTER]:"
read path

find $path/. -type f -exec chmod 600 {} \;
find $path/. -type d -exec chmod 700 {} \; 
find $path/.git/ -type d -exec chmod 775 {} \; 
find $path/.git/ -type f -exec chmod 664 {} \; 
chmod 664 $path/.gitigore 
