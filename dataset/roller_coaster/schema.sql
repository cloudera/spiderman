CREATE DATABASE IF NOT EXISTS `roller_coaster`;

drop table if exists `roller_coaster`.`country`;
CREATE TABLE IF NOT EXISTS `roller_coaster`.`country` (
    `Country_ID` INT,
    `Name` STRING,
    `Population` INT,
    `Area` INT,
    `Languages` STRING,
    PRIMARY KEY (`Country_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/roller_coaster/data/country.csv' INTO TABLE `roller_coaster`.`country`;


drop table if exists `roller_coaster`.`roller_coaster`;
CREATE TABLE IF NOT EXISTS `roller_coaster`.`roller_coaster` (
    `Roller_Coaster_ID` INT,
    `Name` STRING,
    `Park` STRING,
    `Country_ID` INT,
    `Length` REAL,
    `Height` REAL,
    `Speed` STRING,
    `Opened` STRING,
    `Status` STRING,
    PRIMARY KEY (`Roller_Coaster_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Country_ID`) REFERENCES `roller_coaster`.`country` (`Country_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/roller_coaster/data/roller_coaster.csv' INTO TABLE `roller_coaster`.`roller_coaster`;

