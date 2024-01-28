CREATE DATABASE IF NOT EXISTS `election_representative`;

drop table if exists `election_representative`.`representative`;
CREATE TABLE IF NOT EXISTS `election_representative`.`representative` (
    `Representative_ID` INT,
    `Name` STRING,
    `State` STRING,
    `Party` STRING,
    `Lifespan` STRING,
    PRIMARY KEY (`Representative_ID`) DISABLE NOVALIDATE
);

drop table if exists `election_representative`.`election`;
CREATE TABLE IF NOT EXISTS `election_representative`.`election` (
    `Election_ID` INT,
    `Representative_ID` INT,
    `Date` STRING,
    `Votes` DOUBLE,
    `Vote_Percent` DOUBLE,
    `Seats` DOUBLE,
    `Place` DOUBLE,
    PRIMARY KEY (`Election_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Representative_ID`) REFERENCES `election_representative`.`representative` (`Representative_ID`) DISABLE NOVALIDATE
);
