CREATE DATABASE IF NOT EXISTS `battle_death`;

drop table if exists `battle_death`.`battle`;
CREATE TABLE IF NOT EXISTS `battle_death`.`battle` (
    `id` INT,
    `name` STRING,
    `date` STRING,
    `bulgarian_commander` STRING,
    `latin_commander` STRING,
    `result` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/battle_death/data/battle.csv' INTO TABLE `battle_death`.`battle`;


drop table if exists `battle_death`.`ship`;
CREATE TABLE IF NOT EXISTS `battle_death`.`ship` (
    `lost_in_battle` INT,
    `id` INT,
    `name` STRING,
    `tonnage` STRING,
    `ship_type` STRING,
    `location` STRING,
    `disposition_of_ship` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`lost_in_battle`) REFERENCES `battle_death`.`battle` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/battle_death/data/ship.csv' INTO TABLE `battle_death`.`ship`;


drop table if exists `battle_death`.`death`;
CREATE TABLE IF NOT EXISTS `battle_death`.`death` (
    `caused_by_ship_id` INT,
    `id` INT,
    `note` STRING,
    `killed` INT,
    `injured` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`caused_by_ship_id`) REFERENCES `battle_death`.`ship` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/battle_death/data/death.csv' INTO TABLE `battle_death`.`death`;

