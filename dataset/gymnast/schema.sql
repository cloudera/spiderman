CREATE DATABASE IF NOT EXISTS `gymnast`;

drop table if exists `gymnast`.`people`;
CREATE TABLE IF NOT EXISTS `gymnast`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Age` REAL,
    `Height` REAL,
    `Hometown` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/gymnast/data/people.csv' INTO TABLE `gymnast`.`people`;


drop table if exists `gymnast`.`gymnast`;
CREATE TABLE IF NOT EXISTS `gymnast`.`gymnast` (
    `Gymnast_ID` INT,
    `Floor_Exercise_Points` REAL,
    `Pommel_Horse_Points` REAL,
    `Rings_Points` REAL,
    `Vault_Points` REAL,
    `Parallel_Bars_Points` REAL,
    `Horizontal_Bar_Points` REAL,
    `Total_Points` REAL,
    PRIMARY KEY (`Gymnast_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Gymnast_ID`) REFERENCES `gymnast`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/gymnast/data/gymnast.csv' INTO TABLE `gymnast`.`gymnast`;

