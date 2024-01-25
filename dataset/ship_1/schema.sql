drop table if exists `ship_1`.`Ship`;
CREATE TABLE IF NOT EXISTS `ship_1`.`Ship` (
    `Ship_ID` INT,
    `Name` STRING,
    `Type` STRING,
    `Built_Year` REAL,
    `Class` STRING,
    `Flag` STRING,
    PRIMARY KEY (`Ship_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/ship_1/data/Ship.csv' INTO TABLE `ship_1`.`Ship`;


drop table if exists `ship_1`.`captain`;
CREATE TABLE IF NOT EXISTS `ship_1`.`captain` (
    `Captain_ID` INT,
    `Name` STRING,
    `Ship_ID` INT,
    `age` STRING,
    `Class` STRING,
    `Rank` STRING,
    PRIMARY KEY (`Captain_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Ship_ID`) REFERENCES `ship_1`.`Ship` (`Ship_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/ship_1/data/captain.csv' INTO TABLE `ship_1`.`captain`;

