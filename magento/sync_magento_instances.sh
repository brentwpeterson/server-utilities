#! /bin/bash
# Sync 2 Magento instances . support after sync script
# author: Atheotsky

# Source Database informaion - need to update per server setting
SOURCE=$1  # source also can be used to specify help options
TARGET=$2
CONFIRM=$3
SOURCE_XML="$SOURCE/app/etc/local.xml"
TARGET_XML="$TARGET/app/etc/local.xml"

if [ -f $SOURCE_XML ] && [ -f $TARGET_XML ]; then
    S_HOST="$(echo "cat /config/global/resources/default_setup/connection/host/text()" | xmllint --nocdata --shell $SOURCE_XML | sed '1d;$d')"
    S_USER="$(echo "cat /config/global/resources/default_setup/connection/username/text()" | xmllint --nocdata --shell $SOURCE_XML | sed '1d;$d')"
    S_PASS="$(echo "cat /config/global/resources/default_setup/connection/password/text()" | xmllint --nocdata --shell $SOURCE_XML | sed '1d;$d')"
    S_DB="$(echo "cat /config/global/resources/default_setup/connection/dbname/text()" | xmllint --nocdata --shell $SOURCE_XML | sed '1d;$d')"

    # Target database information - need to update per server setting
    T_HOST="$(echo "cat /config/global/resources/default_setup/connection/host/text()" | xmllint --nocdata --shell $TARGET_XML | sed '1d;$d')"
    T_USER="$(echo "cat /config/global/resources/default_setup/connection/username/text()" | xmllint --nocdata --shell $TARGET_XML| sed '1d;$d')"
    T_PASS="$(echo "cat /config/global/resources/default_setup/connection/password/text()" | xmllint --nocdata --shell $TARGET_XML| sed '1d;$d')"
    T_DB="$(echo "cat /config/global/resources/default_setup/connection/dbname/text()" | xmllint --nocdata --shell $TARGET_XML| sed '1d;$d')"

    # On-complete SQL script - need to update to specify the SQL script that will be applied
    SQL="./post_sync.sql"

    # Main backup file where database will be stored - need to update if you want to do it
    S_DUMP="./source_db_dump.sql"
    T_DUMP="./target_db_dump.sql.gz"
fi




############################## DON'T TOUCH BELOW CODE #############################
version="1.0.0
Author : Atheotsky
"
usage="\
    This utility automate sync process between two Magento environments. the following jobs will be done in this order :
    1. mysqldump source and target databases.
    2. set sync target website to maintenance state.
    3. drop all tables from target database.
    4. import source database to target database.
    5. run queries from post_sync.sql file if it EXISTS.
    6. remove maintenance flag.
    7. perform update sync media content (only sync new/updated files).
    8. clear sync target cache.
    
    HOW TO USE :
    1. make this script executable with this command : chmod +x sync_magento_instaces.sh
    2. execute ./sync_magento_instaces.sh source_magento_directory target_magento_directory to review
    3. execute ./sync_magento_instaces.sh LIVE_magento_directory DEV_magento_directory -confirm to process
"
# Linux bin paths, change this if it can not be autodetected via which command
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"
GZIP="$(which gzip)"
CAT="$(which cat)"
RM="$(which rm)"
TOUCH="$(which touch)"
RSYNC="$(which rsync)"

# do the job - support params
if [ -f $SOURCE_XML ] && [ -f $TARGET_XML ] && [ "$CONFIRM" = "-confirm" ]; then
    echo -e "\n1.Making database backup\n"
    $MYSQLDUMP -u$S_USER -p$S_PASS -h $S_HOST $S_DB > $S_DUMP
    $MYSQLDUMP -u$T_USER -p$T_PASS -h $T_HOST $S_DB | $GZIP -9 > $T_DUMP

    echo -e "2.Making maintenance flag\n"
    if [ ! -f "$TARGET/maintenance.flag" ]; then
        $TOUCH "$TARGET/maintenance.flag"
    fi

    echo -e "3.Drop all tables from target database\n"
    $MYSQL -u$T_USER -p$T_PASS -h$T_HOST -BNe "show tables" $T_DB | tr '\n' ',' | sed -e 's/,$//' | awk '{print "SET FOREIGN_KEY_CHECKS = 0;DROP TABLE IF EXISTS " $1 ";SET FOREIGN_KEY_CHECKS = 1;"}' | $MYSQL -u$T_USER -p$T_PASS -h$T_HOST $T_DB

    echo -e "4.Import data from latest dump file\n"
    $MYSQL -u$T_USER -p$T_PASS -h$T_HOST $T_DB < $S_DUMP

    # the script make sure database is usable for target environment
    echo -e "5.Find and execute post_sync.sql script if exists\n"
    if [ -f $SQL ]; then
        $CAT $SQL | $MYSQL -u$T_USER -p$T_PASS -h$T_HOST $T_DB
    fi

    echo -e "6.Remove maintenance flag\n"
    $RM "$TARGET/maintenance.flag"

    echo -e "7.Perform Update Sync Media content\n"
    $RSYNC -avzu "$SOURCE/media/" "$TARGET/media/"

    echo -e "\n8.Clear cache of sync Target\n"
    if [ -d "$TARGET/var/cache" ]; then
        $RM -rfv "$TARGET/var/cache/*"
    fi
    if [ -d "$TARGET/var/full_page_cache" ]; then
        $RM -rfv "$TARGET/var/full_page_cache/*"
    fi

    exit 0

elif [ -f $SOURCE_XML ] && [ -f $TARGET_XML ] && [ "$CONFIRM" != "-confirm" ]; then
    echo -e "\nPlease append -confirm option to process after verifying these information. LAST REMINDER : Database tables on Target will be dropped.

Source :
    - Database : $S_DB
    - Host : $S_HOST
    - Media : $SOURCE/media

Target :
    - Database : $T_DB
    - Host : $T_HOST
    - Media : $TARGET/media
    - Var : $TARGET/var


    Example : ./sync_magento_instaces.sh LIVE_magento_directory DEV_magento_directory -confirm\n\n"

    if [ -f $SQL ]; then
        echo -e "SQL queries will be executed after importing :"
        $CAT $SQL
    fi
    exit 0

elif [ "$SOURCE" = "--help" ] || [ "$SOURCE" = "" ]; then
    echo -e "$usage"
    exit 0

elif [ "$SOURCE" = "--version" ]; then
    echo "Magento Syncs version: $version"
    exit 0
fi
