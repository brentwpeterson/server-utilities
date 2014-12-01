#!/bin/bash
echo "Enter path for local.xml, followed by [ENTER]:"
read path
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
mkdir -p ~/mysql_backup/update
checkfile="~/mysql_backup/$file"
echo $checkfile
if [ -e "$checkfile" ]
then
mv ~/mysql_backup/$file ~/mysql_backup/$file-bak-$(date +%d%m%Y_%H%M).bak
else
#TODO I cant get this to work?
echo 'file doesnt exist'
mv ~/mysql_backup/$file ~/mysql_backup/$file-bak-$(date +%d%m%Y_%H%M).bak
fi
touch ~/mysql_backup/$file
touch ~/mysql_backup/update/clean-log.sql
echo "MAGEFILE=\"$dbs-\$(date +%d%m%Y_%H%M).sql.gz\"" >> ~/mysql_backup/$file
echo "mysql -p'$password' -u $user -h $host $dbs < update/clean-log.sql" >> ~/mysql_backup/$file
echo "mysqldump -p'$password' -u$user -h$host --single-transaction --quick $dbs | gzip > \$MAGEFILE" >> ~/mysql_backup/$file
echo "truncate $prefix dataflow_batch_export;truncate $prefix dataflow_batch_import;truncate $prefix log_customer;truncate $prefix log_quote;truncate $prefix log_summary;truncate $prefix log_summary_type;truncate $prefix log_url;truncate $prefix log_url_info;truncate $prefix log_visitor;truncate $prefix log_visitor_info;truncate $prefix log_visitor_online;truncate $prefix report_viewed_product_index;truncate $prefix report_compared_product_index;truncate $prefix report_event;truncate $prefix sendfriend_log;" > ~/mysql_backup/update/clean-log.sql
else
 echo 'You really screwed up on the path, dude try this again'
fi
