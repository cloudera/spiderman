CREATE DATABASE IF NOT EXISTS `school_player`;

drop table if exists `school_player`.`school`;
CREATE TABLE IF NOT EXISTS `school_player`.`school` (
    `School_ID` INT,
    `School` STRING,
    `Location` STRING,
    `Enrollment` DOUBLE,
    `Founded` DOUBLE,
    `Denomination` STRING,
    `Boys_or_Girls` STRING,
    `Day_or_Boarding` STRING,
    `Year_Entered_Competition` DOUBLE,
    `School_Colors` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE
);

drop table if exists `school_player`.`school_details`;
CREATE TABLE IF NOT EXISTS `school_player`.`school_details` (
    `School_ID` INT,
    `Nickname` STRING,
    `Colors` STRING,
    `League` STRING,
    `Class` STRING,
    `Division` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `school_player`.`school` (`School_ID`) DISABLE NOVALIDATE
);

drop table if exists `school_player`.`school_performance`;
CREATE TABLE IF NOT EXISTS `school_player`.`school_performance` (
    `School_Id` INT,
    `School_Year` STRING,
    `Class_A` STRING,
    `Class_AA` STRING,
    PRIMARY KEY (`School_Id`, `School_Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_Id`) REFERENCES `school_player`.`school` (`School_ID`) DISABLE NOVALIDATE
);

drop table if exists `school_player`.`player`;
CREATE TABLE IF NOT EXISTS `school_player`.`player` (
    `Player_ID` INT,
    `Player` STRING,
    `Team` STRING,
    `Age` INT,
    `Position` STRING,
    `School_ID` INT,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `school_player`.`school` (`School_ID`) DISABLE NOVALIDATE
);
