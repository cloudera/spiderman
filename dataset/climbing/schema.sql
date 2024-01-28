CREATE DATABASE IF NOT EXISTS `climbing`;

drop table if exists `climbing`.`mountain`;
CREATE TABLE IF NOT EXISTS `climbing`.`mountain` (
    `Mountain_ID` INT,
    `Name` STRING,
    `Height` DOUBLE,
    `Prominence` DOUBLE,
    `Range` STRING,
    `Country` STRING,
    PRIMARY KEY (`Mountain_ID`) DISABLE NOVALIDATE
);

drop table if exists `climbing`.`climber`;
CREATE TABLE IF NOT EXISTS `climbing`.`climber` (
    `Climber_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Time` STRING,
    `Points` DOUBLE,
    `Mountain_ID` INT,
    PRIMARY KEY (`Climber_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Mountain_ID`) REFERENCES `climbing`.`mountain` (`Mountain_ID`) DISABLE NOVALIDATE
);
