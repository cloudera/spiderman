CREATE DATABASE IF NOT EXISTS `race_track`;

drop table if exists `race_track`.`track`;
CREATE TABLE IF NOT EXISTS `race_track`.`track` (
    `Track_ID` INT,
    `Name` STRING,
    `Location` STRING,
    `Seating` REAL,
    `Year_Opened` REAL,
    PRIMARY KEY (`Track_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/race_track/data/track.csv' INTO TABLE `race_track`.`track`;


drop table if exists `race_track`.`race`;
CREATE TABLE IF NOT EXISTS `race_track`.`race` (
    `Race_ID` INT,
    `Name` STRING,
    `Class` STRING,
    `Date` STRING,
    `Track_ID` INT,
    PRIMARY KEY (`Race_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Track_ID`) REFERENCES `race_track`.`track` (`Track_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/race_track/data/race.csv' INTO TABLE `race_track`.`race`;

