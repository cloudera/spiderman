CREATE DATABASE IF NOT EXISTS `book_2`;

drop table if exists `book_2`.`book`;
CREATE TABLE IF NOT EXISTS `book_2`.`book` (
    `Book_ID` INT,
    `Title` STRING,
    `Issues` DOUBLE,
    `Writer` STRING,
    PRIMARY KEY (`Book_ID`) DISABLE NOVALIDATE
);

drop table if exists `book_2`.`publication`;
CREATE TABLE IF NOT EXISTS `book_2`.`publication` (
    `Publication_ID` INT,
    `Book_ID` INT,
    `Publisher` STRING,
    `Publication_Date` STRING,
    `Price` DOUBLE,
    PRIMARY KEY (`Publication_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Book_ID`) REFERENCES `book_2`.`book` (`Book_ID`) DISABLE NOVALIDATE
);
