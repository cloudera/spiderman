drop table if exists `ship_mission`.`ship`;
CREATE TABLE IF NOT EXISTS `ship_mission`.`ship` (
    `Ship_ID` INT,
    `Name` STRING,
    `Type` STRING,
    `Nationality` STRING,
    `Tonnage` INT,
    PRIMARY KEY (`Ship_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/ship_mission/data/ship.csv' INTO TABLE `ship_mission`.`ship`;


drop table if exists `ship_mission`.`mission`;
CREATE TABLE IF NOT EXISTS `ship_mission`.`mission` (
    `Mission_ID` INT,
    `Ship_ID` INT,
    `Code` STRING,
    `Launched_Year` INT,
    `Location` STRING,
    `Speed_knots` INT,
    `Fate` STRING,
    PRIMARY KEY (`Mission_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Ship_ID`) REFERENCES `ship_mission`.`ship` (`Ship_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/ship_mission/data/mission.csv' INTO TABLE `ship_mission`.`mission`;

