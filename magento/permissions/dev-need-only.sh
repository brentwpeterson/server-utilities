#!/bin/bash
#########################
# Ask for the app location
# this is from http://www.magentocommerce.com/knowledge-base/entry/install-privs-after
#########################

find $1/. -type f -exec chmod 666 {} \;
find $1/. -type d -exec chmod 777 {} \; 
find $1/.git/ -type d -exec chmod 777 {} \; 
find $1/.git/ -type f -exec chmod 666 {} \; 
chmod 600 $1/.gitignore 
