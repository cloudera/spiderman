CREATE DATABASE IF NOT EXISTS `news_report`;

drop table if exists `news_report`.`event`;
CREATE TABLE IF NOT EXISTS `news_report`.`event` (
    `Event_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Name` STRING,
    `Event_Attendance` INT,
    PRIMARY KEY (`Event_ID`) DISABLE NOVALIDATE
);

drop table if exists `news_report`.`journalist`;
CREATE TABLE IF NOT EXISTS `news_report`.`journalist` (
    `journalist_ID` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Age` STRING,
    `Years_working` INT,
    PRIMARY KEY (`journalist_ID`) DISABLE NOVALIDATE
);

drop table if exists `news_report`.`news_report`;
CREATE TABLE IF NOT EXISTS `news_report`.`news_report` (
    `journalist_ID` INT,
    `Event_ID` INT,
    `Work_Type` STRING,
    PRIMARY KEY (`journalist_ID`, `Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `news_report`.`event` (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`journalist_ID`) REFERENCES `news_report`.`journalist` (`journalist_ID`) DISABLE NOVALIDATE
);
