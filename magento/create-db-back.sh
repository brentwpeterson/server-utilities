#!/bin/bash
echo "Enter path for local.xml (Only enter the application path, not the trailing /), followed by [ENTER]:"
read appath
path="$appath/app/etc/local.xml"
if [ -e "$path" ]
then
echo "Name of file (letsdump.sh is default, followed by [ENTER]:"
read file
file=${file:-letsdump.sh}
dbs=($(cat $path | grep -oP '(?<=<dbname><!\[CDATA\[)[^\]]+'))
host=($(cat $path | grep -oP '(?<=<host><!\[CDATA\[)[^\]]+'))
password=($(cat $path | grep -oP '(?<=<password><!\[CDATA\[)[^\]]+'))
user=($(cat $path | grep -oP '(?<=<username><!\[CDATA\[)[^\]]+'))
prefix=($(cat $path | grep -oP '(?<=<table_prefix><!\[CDATA\[)[^\]]+'))
echo $path
if [ ! -d "$HOME/mysql_backup/update" ]; then
mkdir -p $HOME/mysql_backup/update
fi
checkfile="$HOME/mysql_backup/$file"
if [ -e "$checkfile" ]; then
mv $HOME/mysql_backup/$file $HOME/mysql_backup/$file-bak-$(date +%d%m%Y_%H%M).bak
else
echo 'file doesnt exist'
fi
touch $HOME/mysql_backup/$file
touch $HOME/mysql_backup/update/clean-log.sql
echo "MAGEFILE=\"$dbs-\$(date +%d%m%Y_%H%M).sql.gz\"" >> $HOME/mysql_backup/$file
echo "mysql -p'$password' -u $user -h $host $dbs < update/clean-log.sql" >> $HOME/mysql_backup/$file
echo "mysqldump -p'$password' -u$user -h$host --single-transaction --quick $dbs | gzip > \$MAGEFILE" >> $HOME/mysql_backup/$file
echo "truncate $prefix dataflow_batch_export;truncate $prefix dataflow_batch_import;truncate $prefix log_customer;truncate $prefix log_quote;truncate $prefix log_summary;truncate $prefix log_summary_type;truncate $prefix log_url;truncate $prefix log_url_info;truncate $prefix log_visitor;truncate $prefix log_visitor_info;truncate $prefix log_visitor_online;truncate $prefix report_viewed_product_index;truncate $prefix report_compared_product_index;truncate $prefix report_event;truncate $prefix sendfriend_log;" > $HOME/mysql_backup/update/clean-log.sql
else
 echo "You really screwed up on the path, dude try this again. Did you screw up on the path? -->  $path"
fi
