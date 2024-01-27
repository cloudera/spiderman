CREATE DATABASE IF NOT EXISTS `perpetrator`;

drop table if exists `perpetrator`.`people`;
CREATE TABLE IF NOT EXISTS `perpetrator`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` REAL,
    `Weight` REAL,
    `Home Town` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/perpetrator/data/people.csv' INTO TABLE `perpetrator`.`people`;


drop table if exists `perpetrator`.`perpetrator`;
CREATE TABLE IF NOT EXISTS `perpetrator`.`perpetrator` (
    `Perpetrator_ID` INT,
    `People_ID` INT,
    `Date` STRING,
    `Year` REAL,
    `Location` STRING,
    `Country` STRING,
    `Killed` INT,
    `Injured` INT,
    PRIMARY KEY (`Perpetrator_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `perpetrator`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/perpetrator/data/perpetrator.csv' INTO TABLE `perpetrator`.`perpetrator`;

