-- Dialect: MySQL | Database: ship_mission | Table Count: 2

CREATE DATABASE IF NOT EXISTS `ship_mission`;

DROP TABLE IF EXISTS `ship_mission`.`ship`;
CREATE TABLE `ship_mission`.`ship` (
    `Ship_ID` INT,
    `Name` TEXT,
    `Type` TEXT,
    `Nationality` TEXT,
    `Tonnage` INT,
    PRIMARY KEY (`Ship_ID`)
);

DROP TABLE IF EXISTS `ship_mission`.`mission`;
CREATE TABLE `ship_mission`.`mission` (
    `Mission_ID` INT,
    `Ship_ID` INT,
    `Code` TEXT,
    `Launched_Year` INT,
    `Location` TEXT,
    `Speed_knots` INT,
    `Fate` TEXT,
    PRIMARY KEY (`Mission_ID`),
    FOREIGN KEY (`Ship_ID`) REFERENCES `ship_mission`.`ship` (`Ship_ID`)
);
