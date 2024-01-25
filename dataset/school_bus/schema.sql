drop table if exists `school_bus`.`driver`;
CREATE TABLE IF NOT EXISTS `school_bus`.`driver` (
    `Driver_ID` INT,
    `Name` STRING,
    `Party` STRING,
    `Home_city` STRING,
    `Age` INT,
    PRIMARY KEY (`Driver_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_bus/data/driver.csv' INTO TABLE `school_bus`.`driver`;


drop table if exists `school_bus`.`school`;
CREATE TABLE IF NOT EXISTS `school_bus`.`school` (
    `School_ID` INT,
    `Grade` STRING,
    `School` STRING,
    `Location` STRING,
    `Type` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_bus/data/school.csv' INTO TABLE `school_bus`.`school`;


drop table if exists `school_bus`.`school_bus`;
CREATE TABLE IF NOT EXISTS `school_bus`.`school_bus` (
    `School_ID` INT,
    `Driver_ID` INT,
    `Years_Working` INT,
    `If_full_time` BOOLEAN,
    PRIMARY KEY (`School_ID`, `Driver_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Driver_ID`) REFERENCES `school_bus`.`driver` (`Driver_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `school_bus`.`school` (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_bus/data/school_bus.csv' INTO TABLE `school_bus`.`school_bus`;

