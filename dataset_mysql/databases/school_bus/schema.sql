-- Dialect: MySQL | Database: school_bus | Table Count: 3

CREATE DATABASE IF NOT EXISTS `school_bus`;

DROP TABLE IF EXISTS `school_bus`.`driver`;
CREATE TABLE `school_bus`.`driver` (
    `Driver_ID` INT,
    `Name` TEXT,
    `Party` TEXT,
    `Home_city` TEXT,
    `Age` INT,
    PRIMARY KEY (`Driver_ID`)
);

DROP TABLE IF EXISTS `school_bus`.`school`;
CREATE TABLE `school_bus`.`school` (
    `School_ID` INT,
    `Grade` TEXT,
    `School` TEXT,
    `Location` TEXT,
    `Type` TEXT,
    PRIMARY KEY (`School_ID`)
);

DROP TABLE IF EXISTS `school_bus`.`school_bus`;
CREATE TABLE `school_bus`.`school_bus` (
    `School_ID` INT,
    `Driver_ID` INT,
    `Years_Working` INT,
    `If_full_time` CHAR(1),
    PRIMARY KEY (`School_ID`, `Driver_ID`),
    FOREIGN KEY (`Driver_ID`) REFERENCES `school_bus`.`driver` (`Driver_ID`),
    FOREIGN KEY (`School_ID`) REFERENCES `school_bus`.`school` (`School_ID`)
);
