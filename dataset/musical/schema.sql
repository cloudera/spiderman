CREATE DATABASE IF NOT EXISTS `musical`;

drop table if exists `musical`.`musical`;
CREATE TABLE IF NOT EXISTS `musical`.`musical` (
    `Musical_ID` INT,
    `Name` STRING,
    `Year` INT,
    `Award` STRING,
    `Category` STRING,
    `Nominee` STRING,
    `Result` STRING,
    PRIMARY KEY (`Musical_ID`) DISABLE NOVALIDATE
);

drop table if exists `musical`.`actor`;
CREATE TABLE IF NOT EXISTS `musical`.`actor` (
    `Actor_ID` INT,
    `Name` STRING,
    `Musical_ID` INT,
    `Character` STRING,
    `Duration` STRING,
    `age` INT,
    PRIMARY KEY (`Actor_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Musical_ID`) REFERENCES `musical`.`actor` (`Actor_ID`) DISABLE NOVALIDATE
);
