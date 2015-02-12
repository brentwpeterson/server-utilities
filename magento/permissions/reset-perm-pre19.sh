#!/bin/bash
#########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
# Ask for the app location
#########################
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

find $1/. -type f -exec chmod 644 {} \;
find $1/. -type d -exec chmod 755 {} \;
chmod o+w $1/app/etc
chmod 550 $1/mage
chmod -R o+w $path/var $1/media
