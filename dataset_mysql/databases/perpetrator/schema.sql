-- Dialect: MySQL | Database: perpetrator | Table Count: 2

CREATE DATABASE IF NOT EXISTS `perpetrator`;

DROP TABLE IF EXISTS `perpetrator`.`people`;
CREATE TABLE `perpetrator`.`people` (
    `People_ID` INT,
    `Name` TEXT,
    `Height` REAL,
    `Weight` REAL,
    `Home Town` TEXT,
    PRIMARY KEY (`People_ID`)
);

DROP TABLE IF EXISTS `perpetrator`.`perpetrator`;
CREATE TABLE `perpetrator`.`perpetrator` (
    `Perpetrator_ID` INT,
    `People_ID` INT,
    `Date` TEXT,
    `Year` REAL,
    `Location` TEXT,
    `Country` TEXT,
    `Killed` INT,
    `Injured` INT,
    PRIMARY KEY (`Perpetrator_ID`),
    FOREIGN KEY (`People_ID`) REFERENCES `perpetrator`.`people` (`People_ID`)
);
