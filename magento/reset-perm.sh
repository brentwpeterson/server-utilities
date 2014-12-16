#!/bin/bash
#########################
# Ask for the app location
#########################
echo "Enter path for local.xml (Only enter the application path, not the trailing /), followed by [ENTER]:"
read path

find $path/. -type f -exec chmod 400 {} \;
find $path/. -type d -exec chmod 500 {} \; 
find $path/var/ -type f -exec chmod 600 {} \; 
find $path/media/ -type f -exec chmod 600 {} \;
find $path/var/ -type d -exec chmod 700 {} \; 
find $path/media/ -type d -exec chmod 700 {} \;
chmod 700 $path/includes
chmod 600 $path/includes/config.php
