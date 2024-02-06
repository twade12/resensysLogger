#!/bin/bash

echo "Please desired port number: "
read port

echo "SenScope Username: "
read user

echo "SenScope Password: "
read pw

rm -f siteCommands.sql
rm -f userCommands.sql

sid="$1" # argument passed by user into bash script for site id (format = XXXX)
# build the site-specific .sql file
bash mysql_config2.sh $sid $user $pw
encoded=$(python3 password_encoder.py $pw)

echo "Please use password $encoded in SenScope config"

bash mysql_config3.sh $user $encoded
# create a directory in which to store the sensor data on local machine (binding directory is 2-way sync)
mkdir -p ./mysqlData
