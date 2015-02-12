#!/bin/bash

#########################
# Brent Peterson support@wagento.com
# ** WARNING ** DO NOT USE THIS ON PRODUCTION
# DO NOT USE THIS UNLESS YOU HAVE TESTED IT ON YOUR LOCAL SYSTEM
# DO NOT USE THIS IF YOU HAVE NO IDEA WHAT YOU ARE DOING
# this is from http://www.magentocommerce.com/knowledge-base/entry/install-privs-after
# http://permissions-calculator.org/
#########################
if [ $# -eq 0 ]; then
    echo "No arguments provided"
    exit 1
fi
##
# Take first positional parameter as Magento base directory
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

##
# Don't alter permissions in .git
find "$path" -name '.git' -prune -o -exec chmod -v a=,u+rX {} +

chmod -vR u+w "$path/"{includes,media,var}
chmod -v u+x "$path/"{mage,cron.sh}

