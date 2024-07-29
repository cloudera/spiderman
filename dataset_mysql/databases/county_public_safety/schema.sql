-- Dialect: MySQL | Database: county_public_safety | Table Count: 2

CREATE DATABASE IF NOT EXISTS `county_public_safety`;

DROP TABLE IF EXISTS `county_public_safety`.`county_public_safety`;
CREATE TABLE `county_public_safety`.`county_public_safety` (
    `County_ID` INT,
    `Name` TEXT,
    `Population` INT,
    `Police_officers` INT,
    `Residents_per_officer` INT,
    `Case_burden` INT,
    `Crime_rate` REAL,
    `Police_force` TEXT,
    `Location` TEXT,
    PRIMARY KEY (`County_ID`)
);

DROP TABLE IF EXISTS `county_public_safety`.`city`;
CREATE TABLE `county_public_safety`.`city` (
    `City_ID` INT,
    `County_ID` INT,
    `Name` TEXT,
    `White` REAL,
    `Black` REAL,
    `Amerindian` REAL,
    `Asian` REAL,
    `Multiracial` REAL,
    `Hispanic` REAL,
    PRIMARY KEY (`City_ID`),
    FOREIGN KEY (`County_ID`) REFERENCES `county_public_safety`.`county_public_safety` (`County_ID`)
);
