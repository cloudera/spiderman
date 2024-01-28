CREATE DATABASE IF NOT EXISTS `entrepreneur`;

drop table if exists `entrepreneur`.`people`;
CREATE TABLE IF NOT EXISTS `entrepreneur`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` DOUBLE,
    `Weight` DOUBLE,
    `Date_of_Birth` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
);

drop table if exists `entrepreneur`.`entrepreneur`;
CREATE TABLE IF NOT EXISTS `entrepreneur`.`entrepreneur` (
    `Entrepreneur_ID` INT,
    `People_ID` INT,
    `Company` STRING,
    `Money_Requested` DOUBLE,
    `Investor` STRING,
    PRIMARY KEY (`Entrepreneur_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `entrepreneur`.`people` (`People_ID`) DISABLE NOVALIDATE
);
