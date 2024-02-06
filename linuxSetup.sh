#!/bin/bash

rm -f siteCommands.sql
rm -f userCommands.sql

sid="$1" # argument passed by user into bash script for site id (format = XXXX)
# build the site-specific .sql file
bash mysql_config2.sh $sid
bash mysql_config3.sh
# create a directory in which to store the sensor data on local machine (binding directory is 2-way sync)
mkdir -p ./mysqlData
