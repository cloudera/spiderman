CREATE DATABASE IF NOT EXISTS `scientist_1`;

drop table if exists `scientist_1`.`Scientists`;
CREATE TABLE IF NOT EXISTS `scientist_1`.`Scientists` (
    `SSN` INT,
    `Name` CHAR(30) NOT NULL,
    PRIMARY KEY (`SSN`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/scientist_1/data/Scientists.csv' INTO TABLE `scientist_1`.`Scientists`;


drop table if exists `scientist_1`.`Projects`;
CREATE TABLE IF NOT EXISTS `scientist_1`.`Projects` (
    `Code` CHAR(4),
    `Name` CHAR(50) NOT NULL,
    `Hours` INT,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/scientist_1/data/Projects.csv' INTO TABLE `scientist_1`.`Projects`;


drop table if exists `scientist_1`.`AssignedTo`;
CREATE TABLE IF NOT EXISTS `scientist_1`.`AssignedTo` (
    `Scientist` INT NOT NULL,
    `Project` CHAR(4) NOT NULL,
    PRIMARY KEY (`Scientist`, `Project`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Project`) REFERENCES `scientist_1`.`Projects` (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Scientist`) REFERENCES `scientist_1`.`Scientists` (`SSN`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/scientist_1/data/AssignedTo.csv' INTO TABLE `scientist_1`.`AssignedTo`;

