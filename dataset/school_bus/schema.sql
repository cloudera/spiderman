CREATE DATABASE IF NOT EXISTS `school_bus`;

drop table if exists `school_bus`.`driver`;
CREATE TABLE IF NOT EXISTS `school_bus`.`driver` (
    `Driver_ID` INT,
    `Name` STRING,
    `Party` STRING,
    `Home_city` STRING,
    `Age` INT,
    PRIMARY KEY (`Driver_ID`) DISABLE NOVALIDATE
);

drop table if exists `school_bus`.`school`;
CREATE TABLE IF NOT EXISTS `school_bus`.`school` (
    `School_ID` INT,
    `Grade` STRING,
    `School` STRING,
    `Location` STRING,
    `Type` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE
);

drop table if exists `school_bus`.`school_bus`;
CREATE TABLE IF NOT EXISTS `school_bus`.`school_bus` (
    `School_ID` INT,
    `Driver_ID` INT,
    `Years_Working` INT,
    `If_full_time` BOOLEAN,
    PRIMARY KEY (`School_ID`, `Driver_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Driver_ID`) REFERENCES `school_bus`.`driver` (`Driver_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `school_bus`.`school` (`School_ID`) DISABLE NOVALIDATE
);
