CREATE DATABASE IF NOT EXISTS `theme_gallery`;

drop table if exists `theme_gallery`.`artist`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`artist` (
    `Artist_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Year_Join` INT,
    `Age` INT,
    PRIMARY KEY (`Artist_ID`) DISABLE NOVALIDATE
);

drop table if exists `theme_gallery`.`exhibition`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`exhibition` (
    `Exhibition_ID` INT,
    `Year` INT,
    `Theme` STRING,
    `Artist_ID` INT,
    `Ticket_Price` DOUBLE,
    PRIMARY KEY (`Exhibition_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Artist_ID`) REFERENCES `theme_gallery`.`artist` (`Artist_ID`) DISABLE NOVALIDATE
);

drop table if exists `theme_gallery`.`exhibition_record`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`exhibition_record` (
    `Exhibition_ID` INT,
    `Date` STRING,
    `Attendance` INT,
    PRIMARY KEY (`Exhibition_ID`, `Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Exhibition_ID`) REFERENCES `theme_gallery`.`exhibition` (`Exhibition_ID`) DISABLE NOVALIDATE
);
