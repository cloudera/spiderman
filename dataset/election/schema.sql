CREATE DATABASE IF NOT EXISTS `election`;

drop table if exists `election`.`county`;
CREATE TABLE IF NOT EXISTS `election`.`county` (
    `County_Id` INT,
    `County_name` STRING,
    `Population` DOUBLE,
    `Zip_code` STRING,
    PRIMARY KEY (`County_Id`) DISABLE NOVALIDATE
);

drop table if exists `election`.`party`;
CREATE TABLE IF NOT EXISTS `election`.`party` (
    `Party_ID` INT,
    `Year` DOUBLE,
    `Party` STRING,
    `Governor` STRING,
    `Lieutenant_Governor` STRING,
    `Comptroller` STRING,
    `Attorney_General` STRING,
    `US_Senate` STRING,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE
);

drop table if exists `election`.`election`;
CREATE TABLE IF NOT EXISTS `election`.`election` (
    `Election_ID` INT,
    `Counties_Represented` STRING,
    `District` INT,
    `Delegate` STRING,
    `Party` INT,
    `First_Elected` DOUBLE,
    `Committee` STRING,
    PRIMARY KEY (`Election_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`District`) REFERENCES `election`.`county` (`County_Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party`) REFERENCES `election`.`party` (`Party_ID`) DISABLE NOVALIDATE
);
