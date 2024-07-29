-- Dialect: MySQL | Database: book_2 | Table Count: 2

CREATE DATABASE IF NOT EXISTS `book_2`;

DROP TABLE IF EXISTS `book_2`.`book`;
CREATE TABLE `book_2`.`book` (
    `Book_ID` INT,
    `Title` TEXT,
    `Issues` REAL,
    `Writer` TEXT,
    PRIMARY KEY (`Book_ID`)
);

DROP TABLE IF EXISTS `book_2`.`publication`;
CREATE TABLE `book_2`.`publication` (
    `Publication_ID` INT,
    `Book_ID` INT,
    `Publisher` TEXT,
    `Publication_Date` TEXT,
    `Price` REAL,
    PRIMARY KEY (`Publication_ID`),
    FOREIGN KEY (`Book_ID`) REFERENCES `book_2`.`book` (`Book_ID`)
);
