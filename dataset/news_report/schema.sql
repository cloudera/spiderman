-- Dialect: MySQL | Database: news_report | Table Count: 3

CREATE DATABASE IF NOT EXISTS `news_report`;

DROP TABLE IF EXISTS `news_report`.`event`;
CREATE TABLE `news_report`.`event` (
    `Event_ID` INT,
    `Date` TEXT,
    `Venue` TEXT,
    `Name` TEXT,
    `Event_Attendance` INT,
    PRIMARY KEY (`Event_ID`)
);

DROP TABLE IF EXISTS `news_report`.`journalist`;
CREATE TABLE `news_report`.`journalist` (
    `journalist_ID` INT,
    `Name` TEXT,
    `Nationality` TEXT,
    `Age` TEXT,
    `Years_working` INT,
    PRIMARY KEY (`journalist_ID`)
);

DROP TABLE IF EXISTS `news_report`.`news_report`;
CREATE TABLE `news_report`.`news_report` (
    `journalist_ID` INT,
    `Event_ID` INT,
    `Work_Type` TEXT,
    PRIMARY KEY (`journalist_ID`, `Event_ID`),
    FOREIGN KEY (`Event_ID`) REFERENCES `news_report`.`event` (`Event_ID`),
    FOREIGN KEY (`journalist_ID`) REFERENCES `news_report`.`journalist` (`journalist_ID`)
);
