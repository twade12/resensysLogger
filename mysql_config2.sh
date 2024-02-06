#!/bin/bash
# bash script that constructs site-specific statements
STR="$1"
sid1=${STR:0:2}
sid2=${STR:2:2}
sid=$sid1-$sid2

echo "CREATE DATABASE IF NOT EXISTS \`Data_$1\`;" >> siteCommands.sql
echo "INSERT INTO \`shm-admin\`.\`Accounts\` (\`UserName\`,\`SID\`,\`SIDName\`,\`AccountType\`,\`LastLogin\`,\`Enable\`,\`Password\`,\`LastUpdate\`,\`Email1\`,\`Email2\`,\`Email3\`,\`latitude\`,\`longtitude\`) VALUES('$user','$sid','$sid','Administrator',UTC_TIMESTAMP(),1,'Bridge56#$',UTC_TIMESTAMP(),'','','',0,0);" >> siteCommands.sql
echo "GRANT SELECT ON \`Data_$1\`.* to \`shm-admin\`@\`%\` WITH GRANT OPTION;" >> siteCommands.sql
echo "CREATE TABLE IF NOT EXISTS \`sensors_buffer\`.\`Data_$1\` (\`SiteID\` int(11) unsigned DEFAULT NULL,\`DeviceID\` int(11) unsigned DEFAULT NULL,\`SeqNo\` char(3) DEFAULT NULL,\`Time\` timestamp NULL DEFAULT NULL,\`DataFormat\` int(11) unsigned DEFAULT NULL,\`Value\` int(11) DEFAULT NULL,\`Optional\` int(11) DEFAULT NULL,KEY \`time_index\` (\`Time\`) USING HASH) ENGINE=MyISAM DEFAULT CHARSET=latin1;" >> siteCommands.sql
echo "CREATE TABLE IF NOT EXISTS \`sensors\`.\`Data_$1\` (\`SiteID\` int(11) unsigned DEFAULT NULL,\`DeviceID\` int(11) unsigned DEFAULT NULL,\`SeqNo\` char(3) DEFAULT NULL,\`Time\` timestamp NULL DEFAULT NULL,\`DataFormat\` int(11) unsigned DEFAULT NULL,\`Value\` int(11) DEFAULT NULL,\`Optional\` int(11) DEFAULT NULL,KEY \`time_index\` (\`Time\`) USING HASH) ENGINE=MyISAM DEFAULT CHARSET=latin1;" >> siteCommands.sql
echo "INSERT IGNORE INTO \`shm-admin\`.\`Info\` (\`DID\`, \`TTL\`, \`DES\`, \`TYP\`, \`PFil\`, \`STT\`, \`SID\`, \`FirmVer\`, \`M1\`, \`DOF1\`, \`COF1\`, \`M2\`, \`DOF2\`, \`COF2\`, \`M3\`, \`DOF3\`, \`COF3\`, \`M4\`, \`DOF4\`, \`COF4\`, \`M5\`, \`DOF5\`, \`COF5\`, \`M6\`, \`DOF6\`, \`COF6\`, \`M7\`, \`DOF7\`, \`COF7\`, \`M8\`, \`DOF8\`, \`COF8\`, \`M9\`, \`DOF9\`, \`COF9\`, \`M10\`, \`DOF10\`, \`COF10\`, \`Last_Changed_By\`, \`Last_Update\`) VALUES ('00-00-$sid', 'SNMX $sid', 'Click to Change ...', 'Gateway', '', '1', '$sid', '1', '22002', '0', '0.03675', '29200', '0', '1', '0', '0', '1', '22003', '0', '1', '00000022006', '0', '1.818', '00000000000', '0', '1', '00000003003', '0', '0.0268', '00000022001', '0', '1', '00000000000', '0', '0', '00000000000', '0', '0', 'admin', '2024-01-25 14:12:10');" >> siteCommands.sql
