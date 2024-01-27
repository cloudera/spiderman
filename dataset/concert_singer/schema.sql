CREATE DATABASE IF NOT EXISTS `concert_singer`;

drop table if exists `concert_singer`.`stadium`;
CREATE TABLE IF NOT EXISTS `concert_singer`.`stadium` (
    `Stadium_ID` INT,
    `Location` STRING,
    `Name` STRING,
    `Capacity` INT,
    `Highest` INT,
    `Lowest` INT,
    `Average` INT,
    PRIMARY KEY (`Stadium_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/concert_singer/data/stadium.csv' INTO TABLE `concert_singer`.`stadium`;


drop table if exists `concert_singer`.`singer`;
CREATE TABLE IF NOT EXISTS `concert_singer`.`singer` (
    `Singer_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Song_Name` STRING,
    `Song_release_year` STRING,
    `Age` INT,
    `Is_male` BOOLEAN,
    PRIMARY KEY (`Singer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/concert_singer/data/singer.csv' INTO TABLE `concert_singer`.`singer`;


drop table if exists `concert_singer`.`concert`;
CREATE TABLE IF NOT EXISTS `concert_singer`.`concert` (
    `concert_ID` INT,
    `concert_Name` STRING,
    `Theme` STRING,
    `Stadium_ID` INT,
    `Year` STRING,
    PRIMARY KEY (`concert_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Stadium_ID`) REFERENCES `concert_singer`.`stadium` (`Stadium_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/concert_singer/data/concert.csv' INTO TABLE `concert_singer`.`concert`;


drop table if exists `concert_singer`.`singer_in_concert`;
CREATE TABLE IF NOT EXISTS `concert_singer`.`singer_in_concert` (
    `concert_ID` INT,
    `Singer_ID` INT,
    PRIMARY KEY (`concert_ID`, `Singer_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Singer_ID`) REFERENCES `concert_singer`.`singer` (`Singer_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`concert_ID`) REFERENCES `concert_singer`.`concert` (`concert_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/concert_singer/data/singer_in_concert.csv' INTO TABLE `concert_singer`.`singer_in_concert`;

