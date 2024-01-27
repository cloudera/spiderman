CREATE DATABASE IF NOT EXISTS `train_station`;

drop table if exists `train_station`.`station`;
CREATE TABLE IF NOT EXISTS `train_station`.`station` (
    `Station_ID` INT,
    `Name` STRING,
    `Annual_entry_exit` REAL,
    `Annual_interchanges` REAL,
    `Total_Passengers` REAL,
    `Location` STRING,
    `Main_Services` STRING,
    `Number_of_Platforms` INT,
    PRIMARY KEY (`Station_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/train_station/data/station.csv' INTO TABLE `train_station`.`station`;


drop table if exists `train_station`.`train`;
CREATE TABLE IF NOT EXISTS `train_station`.`train` (
    `Train_ID` INT,
    `Name` STRING,
    `Time` STRING,
    `Service` STRING,
    PRIMARY KEY (`Train_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/train_station/data/train.csv' INTO TABLE `train_station`.`train`;


drop table if exists `train_station`.`train_station`;
CREATE TABLE IF NOT EXISTS `train_station`.`train_station` (
    `Train_ID` INT,
    `Station_ID` INT,
    PRIMARY KEY (`Train_ID`, `Station_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Station_ID`) REFERENCES `train_station`.`station` (`Station_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Train_ID`) REFERENCES `train_station`.`train` (`Train_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/train_station/data/train_station.csv' INTO TABLE `train_station`.`train_station`;

