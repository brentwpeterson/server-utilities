#!/bin/bash
#########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
# Ask for the app location
# this is from http://www.magentocommerce.com/knowledge-base/entry/install-privs-after
#########################
##
# Take first positional parameter as Magento base directory

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

path="$1"

##
# Validate the path
while true; do
    if [[ -d "$path" && -f "$path/app/Mage.php" ]]; then
        break
    elif [[ "$path" ]]; then
        printf '"%s" does not appear to be a valid Magento base directory.\n' "$path"
    fi
    read -p 'Enter the application path, not the trailing /), followed by [ENTER]: ' path
done

##
# Clear the umask so the below permissions are absolute.
umask 0


find $path/. -type f -exec chmod 400 {} \;
find $path/. -type d -exec chmod 500 {} \; 
find $path/var/ -type f -exec chmod 600 {} \; 
find $path/media/ -type f -exec chmod 600 {} \;
find $path/var/ -type d -exec chmod 700 {} \; 
find $path/media/ -type d -exec chmod 700 {} \;
chmod 700 $path/includes
chmod 600 $path/includes/config.php
find $path/.git/ -type d -exec chmod 700 {} \; 
find $path/.git/ -type f -exec chmod 600 {} \; 
chmod 600 $path/.gitignore 
