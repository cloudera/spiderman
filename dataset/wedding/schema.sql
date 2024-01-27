CREATE DATABASE IF NOT EXISTS `wedding`;

drop table if exists `wedding`.`people`;
CREATE TABLE IF NOT EXISTS `wedding`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Is_Male` STRING,
    `Age` INT,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wedding/data/people.csv' INTO TABLE `wedding`.`people`;


drop table if exists `wedding`.`church`;
CREATE TABLE IF NOT EXISTS `wedding`.`church` (
    `Church_ID` INT,
    `Name` STRING,
    `Organized_by` STRING,
    `Open_Date` INT,
    `Continuation_of` STRING,
    PRIMARY KEY (`Church_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wedding/data/church.csv' INTO TABLE `wedding`.`church`;


drop table if exists `wedding`.`wedding`;
CREATE TABLE IF NOT EXISTS `wedding`.`wedding` (
    `Church_ID` INT,
    `Male_ID` INT,
    `Female_ID` INT,
    `Year` INT,
    PRIMARY KEY (`Church_ID`, `Male_ID`, `Female_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Female_ID`) REFERENCES `wedding`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Male_ID`) REFERENCES `wedding`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Church_ID`) REFERENCES `wedding`.`church` (`Church_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wedding/data/wedding.csv' INTO TABLE `wedding`.`wedding`;

