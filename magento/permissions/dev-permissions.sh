#!/bin/bash
#########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
# This requires a value input. 
# Ask for the app location
# this is from http://www.magentocommerce.com/knowledge-base/entry/install-privs-after
#########################

if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi

find $1/. -type f -exec chmod 600 {} \;
find $1/. -type d -exec chmod 700 {} \; 
find $1/.git/ -type d -exec chmod 700 {} \; 
find $1/.git/ -type f -exec chmod 600 {} \; 
chmod 600 $1/.gitignore 
