CREATE DATABASE IF NOT EXISTS `singer`;

drop table if exists `singer`.`singer`;
CREATE TABLE IF NOT EXISTS `singer`.`singer` (
    `Singer_ID` INT,
    `Name` STRING,
    `Birth_Year` REAL,
    `Net_Worth_Millions` REAL,
    `Citizenship` STRING,
    PRIMARY KEY (`Singer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/singer/data/singer.csv' INTO TABLE `singer`.`singer`;


drop table if exists `singer`.`song`;
CREATE TABLE IF NOT EXISTS `singer`.`song` (
    `Song_ID` INT,
    `Title` STRING,
    `Singer_ID` INT,
    `Sales` REAL,
    `Highest_Position` REAL,
    PRIMARY KEY (`Song_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Singer_ID`) REFERENCES `singer`.`singer` (`Singer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/singer/data/song.csv' INTO TABLE `singer`.`song`;

