CREATE DATABASE IF NOT EXISTS `ship_1`;

drop table if exists `ship_1`.`Ship`;
CREATE TABLE IF NOT EXISTS `ship_1`.`Ship` (
    `Ship_ID` INT,
    `Name` STRING,
    `Type` STRING,
    `Built_Year` DOUBLE,
    `Class` STRING,
    `Flag` STRING,
    PRIMARY KEY (`Ship_ID`) DISABLE NOVALIDATE
);

drop table if exists `ship_1`.`captain`;
CREATE TABLE IF NOT EXISTS `ship_1`.`captain` (
    `Captain_ID` INT,
    `Name` STRING,
    `Ship_ID` INT,
    `age` STRING,
    `Class` STRING,
    `Rank` STRING,
    PRIMARY KEY (`Captain_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Ship_ID`) REFERENCES `ship_1`.`Ship` (`Ship_ID`) DISABLE NOVALIDATE
);
