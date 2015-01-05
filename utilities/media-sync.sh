#!/bin/sh
if [ ! "$1" = "" ] ; then
    MEDIASCRIPT=$1
else
    MEDIASCRIPT=rsync-media.sh
fi

MODE=""
if [ ! "$2" = "" ] ; then
	MODE=" $2"
fi

SH_BIN=`which sh`
# absolute path to magento installation
INSTALLDIR=`echo $0 | sed 's/media-sync\.sh//g'`

#	prepend the intallation path if not given an absolute path
if [ "$INSTALLDIR" != "" -a "`expr index $MEDIASCRIPT /`" != "1" ];then
    if ! ps auxwww | grep "$INSTALLDIR$MEDIASCRIPT$MODE" | grep -v grep 1>/dev/null 2>/dev/null ; then
    	$SH_BIN $INSTALLDIR$MEDIASCRIPT$MODE &
    fi
else

    if  ! ps auxwww | grep "$MEDIASCRIPT$MODE" | grep -v grep | grep -v media-sync.sh 1>/dev/null 2>/dev/null ; then
      $SH_BIN $MEDIASCRIPT$MODE &
    fi
fi
