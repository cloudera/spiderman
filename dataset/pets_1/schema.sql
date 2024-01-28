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
);

drop table if exists `pets_1`.`Pets`;
CREATE TABLE IF NOT EXISTS `pets_1`.`Pets` (
    `PetID` INT,
    `PetType` STRING,
    `pet_age` INT,
    `weight` DOUBLE,
    PRIMARY KEY (`PetID`) DISABLE NOVALIDATE
);

drop table if exists `pets_1`.`Has_Pet`;
CREATE TABLE IF NOT EXISTS `pets_1`.`Has_Pet` (
    `StuID` INT,
    `PetID` INT,
    FOREIGN KEY (`StuID`) REFERENCES `pets_1`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`PetID`) REFERENCES `pets_1`.`Pets` (`PetID`) DISABLE NOVALIDATE
);
