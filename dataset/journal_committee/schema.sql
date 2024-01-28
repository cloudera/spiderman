CREATE DATABASE IF NOT EXISTS `journal_committee`;

drop table if exists `journal_committee`.`journal`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`journal` (
    `Journal_ID` INT,
    `Date` STRING,
    `Theme` STRING,
    `Sales` INT,
    PRIMARY KEY (`Journal_ID`) DISABLE NOVALIDATE
);

drop table if exists `journal_committee`.`editor`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`editor` (
    `Editor_ID` INT,
    `Name` STRING,
    `Age` DOUBLE,
    PRIMARY KEY (`Editor_ID`) DISABLE NOVALIDATE
);

drop table if exists `journal_committee`.`journal_committee`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`journal_committee` (
    `Editor_ID` INT,
    `Journal_ID` INT,
    `Work_Type` STRING,
    PRIMARY KEY (`Editor_ID`, `Journal_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Journal_ID`) REFERENCES `journal_committee`.`journal` (`Journal_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Editor_ID`) REFERENCES `journal_committee`.`editor` (`Editor_ID`) DISABLE NOVALIDATE
);
