#!/bin/bash

port=5555
user="shm-admin"
pw="password"

rm -f siteCommands.sql
rm -f userCommands.sql
# rm -rf ./mysqlData
sid="$1" # argument passed by user into bash script for site id (format = XXXX)
# build the site-specific .sql file
bash mysql_config2.sh $sid $user $pw
encoded=$(python3 password_encoder.py $pw)
bash mysql_config3.sh $user $encoded
# create a directory in which to store the sensor data on local machine (binding directory is 2-way sync)
mkdir -p ./mysqlData
# run the docker build network command
docker network rm -f resensys
# run the docker compose with the environmental variables set
SID=$sid PORT=$port USER=$user PW=$pw docker compose up
