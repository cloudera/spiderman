-- Dialect: MySQL | Database: race_track | Table Count: 2

CREATE DATABASE IF NOT EXISTS `race_track`;

DROP TABLE IF EXISTS `race_track`.`track`;
CREATE TABLE `race_track`.`track` (
    `Track_ID` INT,
    `Name` TEXT,
    `Location` TEXT,
    `Seating` REAL,
    `Year_Opened` REAL,
    PRIMARY KEY (`Track_ID`)
);

DROP TABLE IF EXISTS `race_track`.`race`;
CREATE TABLE `race_track`.`race` (
    `Race_ID` INT,
    `Name` TEXT,
    `Class` TEXT,
    `Date` TEXT,
    `Track_ID` INT,
    PRIMARY KEY (`Race_ID`),
    FOREIGN KEY (`Track_ID`) REFERENCES `race_track`.`track` (`Track_ID`)
);
