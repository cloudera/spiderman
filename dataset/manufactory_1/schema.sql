-- Dialect: MySQL | Database: manufactory_1 | Table Count: 2

CREATE DATABASE IF NOT EXISTS `manufactory_1`;

DROP TABLE IF EXISTS `manufactory_1`.`Manufacturers`;
CREATE TABLE `manufactory_1`.`Manufacturers` (
    `Code` INTEGER,
    `Name` VARCHAR(255) NOT NULL,
    `Headquarter` VARCHAR(255) NOT NULL,
    `Founder` VARCHAR(255) NOT NULL,
    `Revenue` REAL,
    PRIMARY KEY (`Code`)
);

DROP TABLE IF EXISTS `manufactory_1`.`Products`;
CREATE TABLE `manufactory_1`.`Products` (
    `Code` INTEGER,
    `Name` VARCHAR(255) NOT NULL,
    `Price` DECIMAL NOT NULL,
    `Manufacturer` INTEGER NOT NULL,
    PRIMARY KEY (`Code`),
    FOREIGN KEY (`Manufacturer`) REFERENCES `manufactory_1`.`Manufacturers` (`Code`)
);
