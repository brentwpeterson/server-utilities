#!/bin/sh
#This must be run from the same directory as teh rsync-media.sh file
if [ ! "$1" = "" ] ; then
    FROMPATH=$1
else
    echo 'You do not have a FROM path set';
	exit;
fi

if [ ! "$2" = "" ] ; then
    TOPATH=$2
else
    echo 'You do not have a TO path set';
      exit;    
fi

PWD=`dirname $0`

if [ ! "$3" = "" ] ; then
    MEDIASCRIPT=$3
else
    MEDIASCRIPT=rsync-media.sh
fi

flock -n /tmp/flock.lock -c "sh $PWD"/"$MEDIASCRIPT $FROMPATH $TOPATH"
