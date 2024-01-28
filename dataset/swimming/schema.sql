CREATE DATABASE IF NOT EXISTS `swimming`;

drop table if exists `swimming`.`swimmer`;
CREATE TABLE IF NOT EXISTS `swimming`.`swimmer` (
    `ID` INT,
    `name` STRING,
    `Nationality` STRING,
    `meter_100` DOUBLE,
    `meter_200` STRING,
    `meter_300` STRING,
    `meter_400` STRING,
    `meter_500` STRING,
    `meter_600` STRING,
    `meter_700` STRING,
    `Time` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE
);

drop table if exists `swimming`.`stadium`;
CREATE TABLE IF NOT EXISTS `swimming`.`stadium` (
    `ID` INT,
    `name` STRING,
    `Capacity` INT,
    `City` STRING,
    `Country` STRING,
    `Opening_year` INT,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE
);

drop table if exists `swimming`.`event`;
CREATE TABLE IF NOT EXISTS `swimming`.`event` (
    `ID` INT,
    `Name` STRING,
    `Stadium_ID` INT,
    `Year` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Stadium_ID`) REFERENCES `swimming`.`stadium` (`ID`) DISABLE NOVALIDATE
);

drop table if exists `swimming`.`record`;
CREATE TABLE IF NOT EXISTS `swimming`.`record` (
    `ID` INT,
    `Result` STRING,
    `Swimmer_ID` INT,
    `Event_ID` INT,
    PRIMARY KEY (`Swimmer_ID`, `Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Swimmer_ID`) REFERENCES `swimming`.`swimmer` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `swimming`.`event` (`ID`) DISABLE NOVALIDATE
);
