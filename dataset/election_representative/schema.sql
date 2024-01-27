CREATE DATABASE IF NOT EXISTS `election_representative`;

drop table if exists `election_representative`.`representative`;
CREATE TABLE IF NOT EXISTS `election_representative`.`representative` (
    `Representative_ID` INT,
    `Name` STRING,
    `State` STRING,
    `Party` STRING,
    `Lifespan` STRING,
    PRIMARY KEY (`Representative_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election_representative/data/representative.csv' INTO TABLE `election_representative`.`representative`;


drop table if exists `election_representative`.`election`;
CREATE TABLE IF NOT EXISTS `election_representative`.`election` (
    `Election_ID` INT,
    `Representative_ID` INT,
    `Date` STRING,
    `Votes` REAL,
    `Vote_Percent` REAL,
    `Seats` REAL,
    `Place` REAL,
    PRIMARY KEY (`Election_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Representative_ID`) REFERENCES `election_representative`.`representative` (`Representative_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election_representative/data/election.csv' INTO TABLE `election_representative`.`election`;

