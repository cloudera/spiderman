-- Dialect: MySQL | Database: musical | Table Count: 2

CREATE DATABASE IF NOT EXISTS `musical`;

DROP TABLE IF EXISTS `musical`.`musical`;
CREATE TABLE `musical`.`musical` (
    `Musical_ID` INT,
    `Name` TEXT,
    `Year` INT,
    `Award` TEXT,
    `Category` TEXT,
    `Nominee` TEXT,
    `Result` TEXT,
    PRIMARY KEY (`Musical_ID`)
);

DROP TABLE IF EXISTS `musical`.`actor`;
CREATE TABLE `musical`.`actor` (
    `Actor_ID` INT,
    `Name` TEXT,
    `Musical_ID` INT,
    `Character` TEXT,
    `Duration` TEXT,
    `age` INT,
    PRIMARY KEY (`Actor_ID`),
    FOREIGN KEY (`Musical_ID`) REFERENCES `musical`.`actor` (`Actor_ID`)
);
