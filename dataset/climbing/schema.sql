drop table if exists `climbing`.`mountain`;
CREATE TABLE IF NOT EXISTS `climbing`.`mountain` (
    `Mountain_ID` INT,
    `Name` STRING,
    `Height` REAL,
    `Prominence` REAL,
    `Range` STRING,
    `Country` STRING,
    PRIMARY KEY (`Mountain_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/climbing/data/mountain.csv' INTO TABLE `climbing`.`mountain`;


drop table if exists `climbing`.`climber`;
CREATE TABLE IF NOT EXISTS `climbing`.`climber` (
    `Climber_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Time` STRING,
    `Points` REAL,
    `Mountain_ID` INT,
    PRIMARY KEY (`Climber_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Mountain_ID`) REFERENCES `climbing`.`mountain` (`Mountain_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/climbing/data/climber.csv' INTO TABLE `climbing`.`climber`;

