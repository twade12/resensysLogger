-- create sensors and sensors_buffer schemas
CREATE DATABASE IF NOT EXISTS `sensors` /*!40100 DEFAULT CHARACTER SET latin1 */;
CREATE DATABASE IF NOT EXISTS `sensors_buffer` /*!40100 DEFAULT CHARACTER SET latin1 */;

-- create the table for handling AirUpdates
CREATE TABLE IF NOT EXISTS `sensors`.`AirUpdate` (
  `idAirUpdate` int(11) NOT NULL AUTO_INCREMENT,
  `SiteId` int(11) unsigned DEFAULT NULL,
  `CommandId` int(11) unsigned DEFAULT NULL,
  `DeviceId` int(11) unsigned DEFAULT NULL,
  `Value` int(11) unsigned DEFAULT NULL,
  `FirmwareVersion` int(10) unsigned DEFAULT NULL,
  `Reserve` int(11) unsigned DEFAULT NULL,
  `Status` int(11) unsigned DEFAULT NULL,
  `InsertionTime` timestamp NULL DEFAULT NULL,
  `ExecutionTime` timestamp NULL DEFAULT NULL,
  `SeqNum` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idAirUpdate`)
) ENGINE=MyISAM AUTO_INCREMENT=21500 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `sensors`.`simInfo` (
  `Time` timestamp NOT NULL,
  `SID` varchar(6) NOT NULL,
  `ICCID` varchar(22) NOT NULL,
  `IMEI` varchar(16) NOT NULL,
  `VER` int(4) NOT NULL,
  `LED` int(6) NOT NULL,
  `Cd0` int(6) NOT NULL,
  `Cd1` int(6) NOT NULL,
  `Cd2` int(6) NOT NULL,
  `Cd3` int(6) NOT NULL,
  `Cd4` int(6) NOT NULL,
  `Cd5` int(6) NOT NULL,
  `Cd6` int(6) NOT NULL,
  `Cd7` int(6) NOT NULL,
  `seq` int(6) NOT NULL,
  KEY `simInfoIndex1` (`Time`,`SID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

SET GLOBAL sql_mode = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
