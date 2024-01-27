CREATE DATABASE IF NOT EXISTS `manufacturer`;

drop table if exists `manufacturer`.`manufacturer`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`manufacturer` (
    `Manufacturer_ID` INT,
    `Open_Year` REAL,
    `Name` STRING,
    `Num_of_Factories` INT,
    `Num_of_Shops` INT,
    PRIMARY KEY (`Manufacturer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufacturer/data/manufacturer.csv' INTO TABLE `manufacturer`.`manufacturer`;


drop table if exists `manufacturer`.`furniture`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`furniture` (
    `Furniture_ID` INT,
    `Name` STRING,
    `Num_of_Component` INT,
    `Market_Rate` REAL,
    PRIMARY KEY (`Furniture_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufacturer/data/furniture.csv' INTO TABLE `manufacturer`.`furniture`;


drop table if exists `manufacturer`.`furniture_manufacte`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`furniture_manufacte` (
    `Manufacturer_ID` INT,
    `Furniture_ID` INT,
    `Price_in_Dollar` REAL,
    PRIMARY KEY (`Manufacturer_ID`, `Furniture_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Furniture_ID`) REFERENCES `manufacturer`.`furniture` (`Furniture_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Manufacturer_ID`) REFERENCES `manufacturer`.`manufacturer` (`Manufacturer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufacturer/data/furniture_manufacte.csv' INTO TABLE `manufacturer`.`furniture_manufacte`;

