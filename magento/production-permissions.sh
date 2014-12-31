#!/bin/bash

#########################
# this is from http://www.magentocommerce.com/knowledge-base/entry/install-privs-after
# http://permissions-calculator.org/
#########################

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

