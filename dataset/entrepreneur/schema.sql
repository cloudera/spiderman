-- Dialect: MySQL | Database: entrepreneur | Table Count: 2

CREATE DATABASE IF NOT EXISTS `entrepreneur`;

DROP TABLE IF EXISTS `entrepreneur`.`people`;
CREATE TABLE `entrepreneur`.`people` (
    `People_ID` INT,
    `Name` TEXT,
    `Height` REAL,
    `Weight` REAL,
    `Date_of_Birth` TEXT,
    PRIMARY KEY (`People_ID`)
);

DROP TABLE IF EXISTS `entrepreneur`.`entrepreneur`;
CREATE TABLE `entrepreneur`.`entrepreneur` (
    `Entrepreneur_ID` INT,
    `People_ID` INT,
    `Company` TEXT,
    `Money_Requested` REAL,
    `Investor` TEXT,
    PRIMARY KEY (`Entrepreneur_ID`),
    FOREIGN KEY (`People_ID`) REFERENCES `entrepreneur`.`people` (`People_ID`)
);
