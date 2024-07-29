-- Dialect: MySQL | Database: singer | Table Count: 2

CREATE DATABASE IF NOT EXISTS `singer`;

DROP TABLE IF EXISTS `singer`.`singer`;
CREATE TABLE `singer`.`singer` (
    `Singer_ID` INT,
    `Name` TEXT,
    `Birth_Year` REAL,
    `Net_Worth_Millions` REAL,
    `Citizenship` TEXT,
    PRIMARY KEY (`Singer_ID`)
);

DROP TABLE IF EXISTS `singer`.`song`;
CREATE TABLE `singer`.`song` (
    `Song_ID` INT,
    `Title` TEXT,
    `Singer_ID` INT,
    `Sales` REAL,
    `Highest_Position` REAL,
    PRIMARY KEY (`Song_ID`),
    FOREIGN KEY (`Singer_ID`) REFERENCES `singer`.`singer` (`Singer_ID`)
);
