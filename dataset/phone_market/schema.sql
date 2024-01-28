CREATE DATABASE IF NOT EXISTS `phone_market`;

drop table if exists `phone_market`.`phone`;
CREATE TABLE IF NOT EXISTS `phone_market`.`phone` (
    `Name` STRING,
    `Phone_ID` INT,
    `Memory_in_G` INT,
    `Carrier` STRING,
    `Price` DOUBLE,
    PRIMARY KEY (`Phone_ID`) DISABLE NOVALIDATE
);

drop table if exists `phone_market`.`market`;
CREATE TABLE IF NOT EXISTS `phone_market`.`market` (
    `Market_ID` INT,
    `District` STRING,
    `Num_of_employees` INT,
    `Num_of_shops` DOUBLE,
    `Ranking` INT,
    PRIMARY KEY (`Market_ID`) DISABLE NOVALIDATE
);

drop table if exists `phone_market`.`phone_market`;
CREATE TABLE IF NOT EXISTS `phone_market`.`phone_market` (
    `Market_ID` INT,
    `Phone_ID` INT,
    `Num_of_stock` INT,
    PRIMARY KEY (`Market_ID`, `Phone_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Phone_ID`) REFERENCES `phone_market`.`phone` (`Phone_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Market_ID`) REFERENCES `phone_market`.`market` (`Market_ID`) DISABLE NOVALIDATE
);
