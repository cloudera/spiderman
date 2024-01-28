CREATE DATABASE IF NOT EXISTS `singer`;

drop table if exists `singer`.`singer`;
CREATE TABLE IF NOT EXISTS `singer`.`singer` (
    `Singer_ID` INT,
    `Name` STRING,
    `Birth_Year` DOUBLE,
    `Net_Worth_Millions` DOUBLE,
    `Citizenship` STRING,
    PRIMARY KEY (`Singer_ID`) DISABLE NOVALIDATE
);

drop table if exists `singer`.`song`;
CREATE TABLE IF NOT EXISTS `singer`.`song` (
    `Song_ID` INT,
    `Title` STRING,
    `Singer_ID` INT,
    `Sales` DOUBLE,
    `Highest_Position` DOUBLE,
    PRIMARY KEY (`Song_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Singer_ID`) REFERENCES `singer`.`singer` (`Singer_ID`) DISABLE NOVALIDATE
);
