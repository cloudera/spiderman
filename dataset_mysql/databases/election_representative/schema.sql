-- Dialect: MySQL | Database: election_representative | Table Count: 2

CREATE DATABASE IF NOT EXISTS `election_representative`;

DROP TABLE IF EXISTS `election_representative`.`representative`;
CREATE TABLE `election_representative`.`representative` (
    `Representative_ID` INT,
    `Name` TEXT,
    `State` TEXT,
    `Party` TEXT,
    `Lifespan` TEXT,
    PRIMARY KEY (`Representative_ID`)
);

DROP TABLE IF EXISTS `election_representative`.`election`;
CREATE TABLE `election_representative`.`election` (
    `Election_ID` INT,
    `Representative_ID` INT,
    `Date` TEXT,
    `Votes` REAL,
    `Vote_Percent` REAL,
    `Seats` REAL,
    `Place` REAL,
    PRIMARY KEY (`Election_ID`),
    FOREIGN KEY (`Representative_ID`) REFERENCES `election_representative`.`representative` (`Representative_ID`)
);
