CREATE DATABASE IF NOT EXISTS `race_track`;

drop table if exists `race_track`.`track`;
CREATE TABLE IF NOT EXISTS `race_track`.`track` (
    `Track_ID` INT,
    `Name` STRING,
    `Location` STRING,
    `Seating` DOUBLE,
    `Year_Opened` DOUBLE,
    PRIMARY KEY (`Track_ID`) DISABLE NOVALIDATE
);

drop table if exists `race_track`.`race`;
CREATE TABLE IF NOT EXISTS `race_track`.`race` (
    `Race_ID` INT,
    `Name` STRING,
    `Class` STRING,
    `Date` STRING,
    `Track_ID` INT,
    PRIMARY KEY (`Race_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Track_ID`) REFERENCES `race_track`.`track` (`Track_ID`) DISABLE NOVALIDATE
);
