CREATE DATABASE IF NOT EXISTS `pets_1`;

drop table if exists `pets_1`.`Student`;
CREATE TABLE IF NOT EXISTS `pets_1`.`Student` (
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
LOAD DATA INPATH '${DATASET_DIR}/pets_1/data/Student.csv' INTO TABLE `pets_1`.`Student`;


drop table if exists `pets_1`.`Pets`;
CREATE TABLE IF NOT EXISTS `pets_1`.`Pets` (
    `PetID` INT,
    `PetType` STRING,
    `pet_age` INT,
    `weight` REAL,
    PRIMARY KEY (`PetID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/pets_1/data/Pets.csv' INTO TABLE `pets_1`.`Pets`;


drop table if exists `pets_1`.`Has_Pet`;
CREATE TABLE IF NOT EXISTS `pets_1`.`Has_Pet` (
    `StuID` INT,
    `PetID` INT,
    FOREIGN KEY (`StuID`) REFERENCES `pets_1`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`PetID`) REFERENCES `pets_1`.`Pets` (`PetID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/pets_1/data/Has_Pet.csv' INTO TABLE `pets_1`.`Has_Pet`;

