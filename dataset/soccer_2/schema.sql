CREATE DATABASE IF NOT EXISTS `soccer_2`;

drop table if exists `soccer_2`.`College`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`College` (
    `cName` STRING NOT NULL,
    `state` STRING,
    `enr` NUMERIC(5,0),
    PRIMARY KEY (`cName`) DISABLE NOVALIDATE
);

drop table if exists `soccer_2`.`Player`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`Player` (
    `pID` NUMERIC(5,0) NOT NULL,
    `pName` STRING,
    `yCard` STRING,
    `HS` NUMERIC(5,0),
    PRIMARY KEY (`pID`) DISABLE NOVALIDATE
);

drop table if exists `soccer_2`.`Tryout`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`Tryout` (
    `pID` NUMERIC(5,0),
    `cName` STRING,
    `pPos` STRING,
    `decision` STRING,
    PRIMARY KEY (`pID`, `cName`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cName`) REFERENCES `soccer_2`.`College` (`cName`) DISABLE NOVALIDATE,
    FOREIGN KEY (`pID`) REFERENCES `soccer_2`.`Player` (`pID`) DISABLE NOVALIDATE
);
