CREATE DATABASE IF NOT EXISTS `manufacturer`;

drop table if exists `manufacturer`.`manufacturer`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`manufacturer` (
    `Manufacturer_ID` INT,
    `Open_Year` DOUBLE,
    `Name` STRING,
    `Num_of_Factories` INT,
    `Num_of_Shops` INT,
    PRIMARY KEY (`Manufacturer_ID`) DISABLE NOVALIDATE
);

drop table if exists `manufacturer`.`furniture`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`furniture` (
    `Furniture_ID` INT,
    `Name` STRING,
    `Num_of_Component` INT,
    `Market_Rate` DOUBLE,
    PRIMARY KEY (`Furniture_ID`) DISABLE NOVALIDATE
);

drop table if exists `manufacturer`.`furniture_manufacte`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`furniture_manufacte` (
    `Manufacturer_ID` INT,
    `Furniture_ID` INT,
    `Price_in_Dollar` DOUBLE,
    PRIMARY KEY (`Manufacturer_ID`, `Furniture_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Furniture_ID`) REFERENCES `manufacturer`.`furniture` (`Furniture_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Manufacturer_ID`) REFERENCES `manufacturer`.`manufacturer` (`Manufacturer_ID`) DISABLE NOVALIDATE
);
