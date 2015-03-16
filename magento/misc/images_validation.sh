#! /bin/bash
# __    __                       _
#/ / /\ \ \__ _  __ _  ___ _ __ | |_ ___
#\ \/  \/ / _` |/ _` |/ _ \ '_ \| __/ _ \
# \  /\  / (_| | (_| |  __/ | | | || (_) |
#  \/  \/ \__,_|\__, |\___|_| |_|\__\___/
#               |___/

# This script is for images validation within your project directory.
# author: Atheotsky

# you can specify targets to scan using scan-list.txt. each directory on a line

LIST=$1  # scan-list.txt
MAILTO=$2

USAGE="\
    This Shell Script scan for images and other files in specified directories
    
    HOW TO USE :
    /path/to/the/script [path scan list] [mail to list, seperate by colon]
"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
FIND="$(which find)"
IDENTIFY="$(which identify)"
MKTEMP="$(which mktemp)"
CAT="$(which cat)"
RM="$(which rm)"
MAIL="$(which mail)"

# log files
IMGLOG=$($MKTEMP)
OTHERLOG=$($MKTEMP)

# assign default list . locate here : ./scan-list.txt
if [ "$LIST" = "" ]; then
    LIST="$DIR/scan-list.txt"
fi
# assign default MAILTO
if [ "$MAILTO" = "" ]; then
    MAILTO="leo@wagento.com,nd.thanh@outlook.com"
fi

# verify image, add to log if it's not a REAL image
process_image() {
    IMAGE=$1
    $IDENTIFY $IMAGE
    if [ $? = 1 ]; then
        echo "$IMAGE is either FAKE image or Corrupted image" >> $IMGLOG
    fi
}
# log other files before sending it to mailto list
process_file() {
    echo "$1<br/>" >> $OTHERLOG
}

IMAGE_PARAMS="-iname '*.jpg' -o -iname '*.png' -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.jpeg' -type f"
OTHER_PARAMS="-not -iname '*.jpg' -not -iname '*.png' -not -iname '*.gif' -not -iname '*.bmp' -not -iname '*.jpeg' -not -type d"

# .Check for scan-list.txt , if not avaiable then will look into the current DIR
if [ -f $LIST ]; then
    while read line; do
        if [ -d "$line" ]; then
            echo "\nScanning $line ..."
            for img in $($FIND $line -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.jpeg' -type f); do
                process_image $img
            done

            for other in $($FIND $line -not -iname '*.jpg' -not -iname '*.png' -not -iname '*.gif' -not -iname '*.bmp' -not -iname '*.jpeg' -not -type d); do
                process_file $other
            done
        else
            echo "\nDirectory [$line] doesn't exist!" >> $OTHERLOG
        fi
    done < $LIST
else
    for img in $($FIND $DIR -iname '*.jpg' -o -iname '*.png' -o -iname '*.gif' -o -iname '*.bmp' -o -iname '*.jpeg' -type f); do
        process_image $img
    done

    for other in $($FIND $DIR -not -iname '*.jpg' -not -iname '*.png' -not -iname '*.gif' -not -iname '*.bmp' -not -iname '*.jpeg' -not -type d); do
        process_file $other
    done
fi

# Send notification
WARNING=$($CAT $IMGLOG)
NOTICE=$($CAT $OTHERLOG)
$RM $IMGLOG; $RM $OTHERLOG

if [ "$WARNING" = "" ]; then
    part1="No suspicious image file found.<br/>"
else
    part1="Fake/Corrupted Image Files: <br/ $WARNING <br/>"
fi

if [ "$NOTICE" = "" ]; then
    part2="<br/>There is no other files beside image files.<br/>"
else
    part2="<br/>List of other files:<br/> $NOTICE"
fi

echo $part1$part2 | $MAIL -s "$(echo -e "Files Scan Security Report\nContent-Type: text/html")" -- $MAILTO
