-- Dialect: MySQL | Database: climbing | Table Count: 2

CREATE DATABASE IF NOT EXISTS `climbing`;

DROP TABLE IF EXISTS `climbing`.`mountain`;
CREATE TABLE `climbing`.`mountain` (
    `Mountain_ID` INT,
    `Name` TEXT,
    `Height` REAL,
    `Prominence` REAL,
    `Range` TEXT,
    `Country` TEXT,
    PRIMARY KEY (`Mountain_ID`)
);

DROP TABLE IF EXISTS `climbing`.`climber`;
CREATE TABLE `climbing`.`climber` (
    `Climber_ID` INT,
    `Name` TEXT,
    `Country` TEXT,
    `Time` TEXT,
    `Points` REAL,
    `Mountain_ID` INT,
    PRIMARY KEY (`Climber_ID`),
    FOREIGN KEY (`Mountain_ID`) REFERENCES `climbing`.`mountain` (`Mountain_ID`)
);
