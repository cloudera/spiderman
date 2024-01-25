drop table if exists `election`.`county`;
CREATE TABLE IF NOT EXISTS `election`.`county` (
    `County_Id` INT,
    `County_name` STRING,
    `Population` REAL,
    `Zip_code` STRING,
    PRIMARY KEY (`County_Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election/data/county.csv' INTO TABLE `election`.`county`;


drop table if exists `election`.`party`;
CREATE TABLE IF NOT EXISTS `election`.`party` (
    `Party_ID` INT,
    `Year` REAL,
    `Party` STRING,
    `Governor` STRING,
    `Lieutenant_Governor` STRING,
    `Comptroller` STRING,
    `Attorney_General` STRING,
    `US_Senate` STRING,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election/data/party.csv' INTO TABLE `election`.`party`;


drop table if exists `election`.`election`;
CREATE TABLE IF NOT EXISTS `election`.`election` (
    `Election_ID` INT,
    `Counties_Represented` STRING,
    `District` INT,
    `Delegate` STRING,
    `Party` INT,
    `First_Elected` REAL,
    `Committee` STRING,
    PRIMARY KEY (`Election_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`District`) REFERENCES `election`.`county` (`County_Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party`) REFERENCES `election`.`party` (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election/data/election.csv' INTO TABLE `election`.`election`;

