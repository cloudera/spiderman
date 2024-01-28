CREATE DATABASE IF NOT EXISTS `manufactory_1`;

drop table if exists `manufactory_1`.`Manufacturers`;
CREATE TABLE IF NOT EXISTS `manufactory_1`.`Manufacturers` (
    `Code` INT,
    `Name` STRING NOT NULL,
    `Headquarter` STRING NOT NULL,
    `Founder` STRING NOT NULL,
    `Revenue` DOUBLE,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
);

drop table if exists `manufactory_1`.`Products`;
CREATE TABLE IF NOT EXISTS `manufactory_1`.`Products` (
    `Code` INT,
    `Name` STRING NOT NULL,
    `Price` DECIMAL NOT NULL,
    `Manufacturer` INT NOT NULL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Manufacturer`) REFERENCES `manufactory_1`.`Manufacturers` (`Code`) DISABLE NOVALIDATE
);
