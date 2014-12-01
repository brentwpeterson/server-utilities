#!/bin/bash
echo "Enter path for local.xml, followed by [ENTER]:"
read path
dbs=($(cat $path | grep -oP '(?<=<dbname><!\[CDATA\[)[^\]]+'))
host=($(cat $path | grep -oP '(?<=<host><!\[CDATA\[)[^\]]+'))
password=($(cat $path | grep -oP '(?<=<password><!\[CDATA\[)[^\]]+'))
user=($(cat $path | grep -oP '(?<=<username><!\[CDATA\[)[^\]]+'))
prefix=($(cat $path | grep -oP '(?<=<table_prefix><!\[CDATA\[)[^\]]+'))
echo $path
mkdir -p ~/mysql_backup/update
mv ~/mysql_backup/letsdump.sh ~/mysql_backup/letdump-$(date +%d%m%Y_%H%M).bak
touch ~/mysql_backup/letsdump.sh
touch ~/mysql_backup/update/clean-log.sql
echo "MAGEFILE=\"$dbs-\$(date +%d%m%Y_%H%M).sql.gz\"" >> ~/mysql_backup/letsdump.sh
echo "mysql -p'$password' -u $user $dbs < update/clean-log.sql" >> ~/mysql_backup/letsdump.sh
echo "mysqldump -p'$password' -u$user --single-transaction --quick $dbs | gzip > \$MAGEFILE" >> ~/mysql_backup/letsdump.sh
echo "truncate $prefix dataflow_batch_export;truncate $prefix dataflow_batch_import;truncate $prefix log_customer;truncate $prefix log_quote;truncate $prefix log_summary;truncate $prefix log_summary_type;truncate $prefix log_url;truncate $prefix log_url_info;truncate $prefix log_visitor;truncate $prefix log_visitor_info;truncate $prefix log_visitor_online;truncate $prefix report_viewed_product_index;truncate $prefix report_compared_product_index;truncate $prefix report_event;truncate $prefix sendfriend_log;" > ~/mysql_backup/update/clean-log.sql
