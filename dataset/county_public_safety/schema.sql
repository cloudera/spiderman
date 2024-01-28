CREATE DATABASE IF NOT EXISTS `county_public_safety`;

drop table if exists `county_public_safety`.`county_public_safety`;
CREATE TABLE IF NOT EXISTS `county_public_safety`.`county_public_safety` (
    `County_ID` INT,
    `Name` STRING,
    `Population` INT,
    `Police_officers` INT,
    `Residents_per_officer` INT,
    `Case_burden` INT,
    `Crime_rate` DOUBLE,
    `Police_force` STRING,
    `Location` STRING,
    PRIMARY KEY (`County_ID`) DISABLE NOVALIDATE
);

drop table if exists `county_public_safety`.`city`;
CREATE TABLE IF NOT EXISTS `county_public_safety`.`city` (
    `City_ID` INT,
    `County_ID` INT,
    `Name` STRING,
    `White` DOUBLE,
    `Black` DOUBLE,
    `Amerindian` DOUBLE,
    `Asian` DOUBLE,
    `Multiracial` DOUBLE,
    `Hispanic` DOUBLE,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`County_ID`) REFERENCES `county_public_safety`.`county_public_safety` (`County_ID`) DISABLE NOVALIDATE
);
