CREATE DATABASE IF NOT EXISTS `csu_1`;

drop table if exists `csu_1`.`Campuses`;
CREATE TABLE IF NOT EXISTS `csu_1`.`Campuses` (
    `Id` INT,
    `Campus` STRING,
    `Location` STRING,
    `County` STRING,
    `Year` INT,
    PRIMARY KEY (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/Campuses.csv' INTO TABLE `csu_1`.`Campuses`;


drop table if exists `csu_1`.`csu_fees`;
CREATE TABLE IF NOT EXISTS `csu_1`.`csu_fees` (
    `Campus` INT,
    `Year` INT,
    `CampusFee` INT,
    PRIMARY KEY (`Campus`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/csu_fees.csv' INTO TABLE `csu_1`.`csu_fees`;


drop table if exists `csu_1`.`degrees`;
CREATE TABLE IF NOT EXISTS `csu_1`.`degrees` (
    `Year` INT,
    `Campus` INT,
    `Degrees` INT,
    PRIMARY KEY (`Year`, `Campus`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/degrees.csv' INTO TABLE `csu_1`.`degrees`;


drop table if exists `csu_1`.`discipline_enrollments`;
CREATE TABLE IF NOT EXISTS `csu_1`.`discipline_enrollments` (
    `Campus` INT,
    `Discipline` INT,
    `Year` INT,
    `Undergraduate` INT,
    `Graduate` INT,
    PRIMARY KEY (`Campus`, `Discipline`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/discipline_enrollments.csv' INTO TABLE `csu_1`.`discipline_enrollments`;


drop table if exists `csu_1`.`enrollments`;
CREATE TABLE IF NOT EXISTS `csu_1`.`enrollments` (
    `Campus` INT,
    `Year` INT,
    `TotalEnrollment_AY` INT,
    `FTE_AY` INT,
    PRIMARY KEY (`Campus`, `Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/enrollments.csv' INTO TABLE `csu_1`.`enrollments`;


drop table if exists `csu_1`.`faculty`;
CREATE TABLE IF NOT EXISTS `csu_1`.`faculty` (
    `Campus` INT,
    `Year` INT,
    `Faculty` REAL,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/faculty.csv' INTO TABLE `csu_1`.`faculty`;

