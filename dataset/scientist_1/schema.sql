-- Dialect: MySQL | Database: scientist_1 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `scientist_1`;

DROP TABLE IF EXISTS `scientist_1`.`Scientists`;
CREATE TABLE `scientist_1`.`Scientists` (
    `SSN` INT,
    `Name` CHAR(30) NOT NULL,
    PRIMARY KEY (`SSN`)
);

DROP TABLE IF EXISTS `scientist_1`.`Projects`;
CREATE TABLE `scientist_1`.`Projects` (
    `Code` CHAR(4),
    `Name` CHAR(50) NOT NULL,
    `Hours` INT,
    PRIMARY KEY (`Code`)
);

DROP TABLE IF EXISTS `scientist_1`.`AssignedTo`;
CREATE TABLE `scientist_1`.`AssignedTo` (
    `Scientist` INT NOT NULL,
    `Project` CHAR(4) NOT NULL,
    PRIMARY KEY (`Scientist`, `Project`),
    FOREIGN KEY (`Project`) REFERENCES `scientist_1`.`Projects` (`Code`),
    FOREIGN KEY (`Scientist`) REFERENCES `scientist_1`.`Scientists` (`SSN`)
);
