-- Dialect: MySQL | Database: swimming | Table Count: 4

CREATE DATABASE IF NOT EXISTS `swimming`;

DROP TABLE IF EXISTS `swimming`.`swimmer`;
CREATE TABLE `swimming`.`swimmer` (
    `ID` INT,
    `name` TEXT,
    `Nationality` TEXT,
    `meter_100` REAL,
    `meter_200` TEXT,
    `meter_300` TEXT,
    `meter_400` TEXT,
    `meter_500` TEXT,
    `meter_600` TEXT,
    `meter_700` TEXT,
    `Time` TEXT,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `swimming`.`stadium`;
CREATE TABLE `swimming`.`stadium` (
    `ID` INT,
    `name` TEXT,
    `Capacity` INT,
    `City` TEXT,
    `Country` TEXT,
    `Opening_year` INT,
    PRIMARY KEY (`ID`)
);

DROP TABLE IF EXISTS `swimming`.`event`;
CREATE TABLE `swimming`.`event` (
    `ID` INT,
    `Name` TEXT,
    `Stadium_ID` INT,
    `Year` TEXT,
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`Stadium_ID`) REFERENCES `swimming`.`stadium` (`ID`)
);

DROP TABLE IF EXISTS `swimming`.`record`;
CREATE TABLE `swimming`.`record` (
    `ID` INT,
    `Result` TEXT,
    `Swimmer_ID` INT,
    `Event_ID` INT,
    PRIMARY KEY (`Swimmer_ID`, `Event_ID`),
    FOREIGN KEY (`Swimmer_ID`) REFERENCES `swimming`.`swimmer` (`ID`),
    FOREIGN KEY (`Event_ID`) REFERENCES `swimming`.`event` (`ID`)
);