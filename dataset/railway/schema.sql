drop table if exists `railway`.`railway`;
CREATE TABLE IF NOT EXISTS `railway`.`railway` (
    `Railway_ID` INT,
    `Railway` STRING,
    `Builder` STRING,
    `Built` STRING,
    `Wheels` STRING,
    `Location` STRING,
    `ObjectNumber` STRING,
    PRIMARY KEY (`Railway_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/railway/data/railway.csv' INTO TABLE `railway`.`railway`;


drop table if exists `railway`.`train`;
CREATE TABLE IF NOT EXISTS `railway`.`train` (
    `Train_ID` INT,
    `Train_Num` STRING,
    `Name` STRING,
    `From` STRING,
    `Arrival` STRING,
    `Railway_ID` INT,
    PRIMARY KEY (`Train_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Railway_ID`) REFERENCES `railway`.`railway` (`Railway_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/railway/data/train.csv' INTO TABLE `railway`.`train`;


drop table if exists `railway`.`manager`;
CREATE TABLE IF NOT EXISTS `railway`.`manager` (
    `Manager_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Working_year_starts` STRING,
    `Age` INT,
    `Level` INT,
    PRIMARY KEY (`Manager_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/railway/data/manager.csv' INTO TABLE `railway`.`manager`;


drop table if exists `railway`.`railway_manage`;
CREATE TABLE IF NOT EXISTS `railway`.`railway_manage` (
    `Railway_ID` INT,
    `Manager_ID` INT,
    `From_Year` STRING,
    PRIMARY KEY (`Railway_ID`, `Manager_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Railway_ID`) REFERENCES `railway`.`railway` (`Railway_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Manager_ID`) REFERENCES `railway`.`manager` (`Manager_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/railway/data/railway_manage.csv' INTO TABLE `railway`.`railway_manage`;
