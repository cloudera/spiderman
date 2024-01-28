CREATE DATABASE IF NOT EXISTS `perpetrator`;

drop table if exists `perpetrator`.`people`;
CREATE TABLE IF NOT EXISTS `perpetrator`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` DOUBLE,
    `Weight` DOUBLE,
    `Home Town` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
);

drop table if exists `perpetrator`.`perpetrator`;
CREATE TABLE IF NOT EXISTS `perpetrator`.`perpetrator` (
    `Perpetrator_ID` INT,
    `People_ID` INT,
    `Date` STRING,
    `Year` DOUBLE,
    `Location` STRING,
    `Country` STRING,
    `Killed` INT,
    `Injured` INT,
    PRIMARY KEY (`Perpetrator_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `perpetrator`.`people` (`People_ID`) DISABLE NOVALIDATE
);
