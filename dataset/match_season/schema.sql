CREATE DATABASE IF NOT EXISTS `match_season`;

drop table if exists `match_season`.`country`;
CREATE TABLE IF NOT EXISTS `match_season`.`country` (
    `Country_id` INT,
    `Country_name` STRING,
    `Capital` STRING,
    `Official_native_language` STRING,
    PRIMARY KEY (`Country_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/match_season/data/country.csv' INTO TABLE `match_season`.`country`;


drop table if exists `match_season`.`team`;
CREATE TABLE IF NOT EXISTS `match_season`.`team` (
    `Team_id` INT,
    `Name` STRING,
    PRIMARY KEY (`Team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/match_season/data/team.csv' INTO TABLE `match_season`.`team`;


drop table if exists `match_season`.`match_season`;
CREATE TABLE IF NOT EXISTS `match_season`.`match_season` (
    `Season` REAL,
    `Player` STRING,
    `Position` STRING,
    `Country` INT,
    `Team` INT,
    `Draft_Pick_Number` INT,
    `Draft_Class` STRING,
    `College` STRING,
    PRIMARY KEY (`Season`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Team`) REFERENCES `match_season`.`team` (`Team_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Country`) REFERENCES `match_season`.`country` (`Country_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/match_season/data/match_season.csv' INTO TABLE `match_season`.`match_season`;


drop table if exists `match_season`.`player`;
CREATE TABLE IF NOT EXISTS `match_season`.`player` (
    `Player_ID` INT,
    `Player` STRING,
    `Years_Played` STRING,
    `Total_WL` STRING,
    `Singles_WL` STRING,
    `Doubles_WL` STRING,
    `Team` INT,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Team`) REFERENCES `match_season`.`team` (`Team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/match_season/data/player.csv' INTO TABLE `match_season`.`player`;

