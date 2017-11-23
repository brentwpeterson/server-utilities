#!/bin/bash
DB='DB'
URL='http://www.example.com'
VALUEARRAY='(2,3)'
MYSQL='mysql'
sudo $MYSQL -e "use $DB; update core_config_data set value = '$URL' where config_id in $VALUEARRAY;"
