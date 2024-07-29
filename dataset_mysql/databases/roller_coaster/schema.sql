-- Dialect: MySQL | Database: roller_coaster | Table Count: 2

CREATE DATABASE IF NOT EXISTS `roller_coaster`;

DROP TABLE IF EXISTS `roller_coaster`.`country`;
CREATE TABLE `roller_coaster`.`country` (
    `Country_ID` INT,
    `Name` TEXT,
    `Population` INT,
    `Area` INT,
    `Languages` TEXT,
    PRIMARY KEY (`Country_ID`)
);

DROP TABLE IF EXISTS `roller_coaster`.`roller_coaster`;
CREATE TABLE `roller_coaster`.`roller_coaster` (
    `Roller_Coaster_ID` INT,
    `Name` TEXT,
    `Park` TEXT,
    `Country_ID` INT,
    `Length` REAL,
    `Height` REAL,
    `Speed` TEXT,
    `Opened` TEXT,
    `Status` TEXT,
    PRIMARY KEY (`Roller_Coaster_ID`),
    FOREIGN KEY (`Country_ID`) REFERENCES `roller_coaster`.`country` (`Country_ID`)
);
