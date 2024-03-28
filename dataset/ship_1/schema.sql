-- Dialect: MySQL | Database: ship_1 | Table Count: 2

CREATE DATABASE IF NOT EXISTS `ship_1`;

DROP TABLE IF EXISTS `ship_1`.`Ship`;
CREATE TABLE `ship_1`.`Ship` (
    `Ship_ID` INT,
    `Name` TEXT,
    `Type` TEXT,
    `Built_Year` REAL,
    `Class` TEXT,
    `Flag` TEXT,
    PRIMARY KEY (`Ship_ID`)
);

DROP TABLE IF EXISTS `ship_1`.`captain`;
CREATE TABLE `ship_1`.`captain` (
    `Captain_ID` INT,
    `Name` TEXT,
    `Ship_ID` INT,
    `age` TEXT,
    `Class` TEXT,
    `Rank` TEXT,
    PRIMARY KEY (`Captain_ID`),
    FOREIGN KEY (`Ship_ID`) REFERENCES `ship_1`.`Ship` (`Ship_ID`)
);
