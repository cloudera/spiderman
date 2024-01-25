drop table if exists `county_public_safety`.`county_public_safety`;
CREATE TABLE IF NOT EXISTS `county_public_safety`.`county_public_safety` (
    `County_ID` INT,
    `Name` STRING,
    `Population` INT,
    `Police_officers` INT,
    `Residents_per_officer` INT,
    `Case_burden` INT,
    `Crime_rate` REAL,
    `Police_force` STRING,
    `Location` STRING,
    PRIMARY KEY (`County_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/county_public_safety/data/county_public_safety.csv' INTO TABLE `county_public_safety`.`county_public_safety`;


drop table if exists `county_public_safety`.`city`;
CREATE TABLE IF NOT EXISTS `county_public_safety`.`city` (
    `City_ID` INT,
    `County_ID` INT,
    `Name` STRING,
    `White` REAL,
    `Black` REAL,
    `Amerindian` REAL,
    `Asian` REAL,
    `Multiracial` REAL,
    `Hispanic` REAL,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`County_ID`) REFERENCES `county_public_safety`.`county_public_safety` (`County_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/county_public_safety/data/city.csv' INTO TABLE `county_public_safety`.`city`;

