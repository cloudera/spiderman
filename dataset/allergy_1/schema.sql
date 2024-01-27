CREATE DATABASE IF NOT EXISTS `allergy_1`;

drop table if exists `allergy_1`.`Allergy_Type`;
CREATE TABLE IF NOT EXISTS `allergy_1`.`Allergy_Type` (
    `Allergy` STRING,
    `AllergyType` STRING,
    PRIMARY KEY (`Allergy`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/allergy_1/data/Allergy_Type.csv' INTO TABLE `allergy_1`.`Allergy_Type`;


drop table if exists `allergy_1`.`Student`;
CREATE TABLE IF NOT EXISTS `allergy_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/allergy_1/data/Student.csv' INTO TABLE `allergy_1`.`Student`;


drop table if exists `allergy_1`.`Has_Allergy`;
CREATE TABLE IF NOT EXISTS `allergy_1`.`Has_Allergy` (
    `StuID` INT,
    `Allergy` STRING,
    FOREIGN KEY (`Allergy`) REFERENCES `allergy_1`.`Allergy_Type` (`Allergy`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `allergy_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/allergy_1/data/Has_Allergy.csv' INTO TABLE `allergy_1`.`Has_Allergy`;

