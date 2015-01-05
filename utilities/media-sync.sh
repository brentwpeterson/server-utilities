#!/bin/sh
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

if [ ! "$3" = "" ] ; then
    MEDIASCRIPT=$3
else
    MEDIASCRIPT=rsync-media.sh
fi


SH_BIN=`which sh`
# absolute path to magento installation
INSTALLDIR=`echo $0 | sed 's/media-sync\.sh//g'`

#	prepend the intallation path if not given an absolute path
if [ "$INSTALLDIR" != "" -a "`expr index $MEDIASCRIPT /`" != "1" ];then
    if ! ps auxwww | grep "$INSTALLDIR$MEDIASCRIPT$FROMPATH$TOPATH" | grep -v grep 1>/dev/null 2>/dev/null ; then
    	$SH_BIN $INSTALLDIR$MEDIASCRIPT$FROMPATH$TOPATH &
    fi
else

    if  ! ps auxwww | grep "$MEDIASCRIPT$FROMPATH$TOPATH" | grep -v grep | grep -v media-sync.sh 1>/dev/null 2>/dev/null ; then
      $SH_BIN $MEDIASCRIPT$FROMPATH$TOPATH &
    fi
fi
