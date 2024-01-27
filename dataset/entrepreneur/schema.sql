CREATE DATABASE IF NOT EXISTS `entrepreneur`;

drop table if exists `entrepreneur`.`people`;
CREATE TABLE IF NOT EXISTS `entrepreneur`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` REAL,
    `Weight` REAL,
    `Date_of_Birth` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entrepreneur/data/people.csv' INTO TABLE `entrepreneur`.`people`;


drop table if exists `entrepreneur`.`entrepreneur`;
CREATE TABLE IF NOT EXISTS `entrepreneur`.`entrepreneur` (
    `Entrepreneur_ID` INT,
    `People_ID` INT,
    `Company` STRING,
    `Money_Requested` REAL,
    `Investor` STRING,
    PRIMARY KEY (`Entrepreneur_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `entrepreneur`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entrepreneur/data/entrepreneur.csv' INTO TABLE `entrepreneur`.`entrepreneur`;

