#!/usr/bin/bash
if [ `whoami` != "root" ]; then
  echo "You must be r00t!" >&2
  exit 1
fi
dbquery=$(mysql -h mysql-container -u root "-pBridgeWatcher6517" -N sensors -e "select table_name from information_schema.tables where table_schema = 'sensors' and (table_name = 'Data_$1');")
array=( $( for i in $dbquery ; do echo $i ; done ) )
cnt=${#array[@]}
for (( i=0 ; i<cnt ; i++ ))
do 
echo "Record No. $i: ${array[$i]}"
table_name="${array[$i]}"
size=${#table_name}
if [ "$size" = "9" ];then
sit_id=$(echo $table_name| cut -d'_' -f 2)
#if [ "$sit_id" = "1617" ] ||  [ "$sit_id" = "1618" ] || [ "$sit_id" = "1F03" ] || [ "$sit_id" = "1F06" ];then
echo table_name=$table_name ... site_id=$sit_id
#mysql "-p3116" -N -e "select max(Time) from sensors.$table_name" > max_time.txt
max_time=$(mysql -h mysql-container -u root "-pBridgeWatcher6517" -N -e "select max(Time) from \`$table_name\`.\`Data.0000$sit_id.$sit_id.3003\`;")
if [ "${#max_time}" = "0" ];then
max_time="2000-01-00 00:00:00"
# mysql -h mysql-container -u root "-pBridgeWatcher6517" -N -D sensors_buffer -e "IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE schema_name = '$table_name' ) BEGIN CREATE SCHEMA $table_name END"
fi
echo max_bckedup_time=$max_time 
mysql -h mysql-container -u root "-pBridgeWatcher6517" -N -D sensors_buffer -e "DROP TABLE $table_name;"
mysql -h mysql-container -u root "-pBridgeWatcher6517" -N -D sensors_buffer -e "CREATE TABLE IF NOT EXISTS $table_name (\`SiteID\` int(11) unsigned DEFAULT NULL,\`DeviceID\` int(11) unsigned DEFAULT NULL,\`SeqNo\` char(3) DEFAULT NULL, \`Time\` timestamp NULL DEFAULT CURRENT_TIMESTAMP,\`DataFormat\` int(11) unsigned DEFAULT NULL, \`Value\` int(11) DEFAULT NULL,\`Optional\` int(11) DEFAULT NULL, KEY \`time_index\` (\`Time\`) USING HASH) ENGINE=MyISAM DEFAULT CHARSET=latin1;"
mysqldump -h mysql-container -u root "-pBridgeWatcher6517" sensors $table_name --where="Time > '$max_time'" --skip-add-drop-table --no-create-info --skip-tz-utc --lock-tables=false | mysql -h mysql-container -u root "-pBridgeWatcher6517" -D sensors_buffer 

./DBUpdate $table_name
#mysql "-p3116" -N -D sensors -e "CREATE TABLE IF NOT EXISTS Data_$1_Temp LIKE Data_0104;"
#mysql "-p3116" -N -D sensors -e "RENAME TABLE Data_$1 TO Data_$1_OLD, Data_$1_Temp TO Data_$1;"
#mysql "-p3116" -N -D sensors -e "DROP TABLE Data_$1_OLD;"
fi
# fi
#fi
done
