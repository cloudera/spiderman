-- Dialect: MySQL | Database: school_player | Table Count: 4

CREATE DATABASE IF NOT EXISTS `school_player`;

DROP TABLE IF EXISTS `school_player`.`school`;
CREATE TABLE `school_player`.`school` (
    `School_ID` INT,
    `School` TEXT,
    `Location` TEXT,
    `Enrollment` REAL,
    `Founded` REAL,
    `Denomination` TEXT,
    `Boys_or_Girls` TEXT,
    `Day_or_Boarding` TEXT,
    `Year_Entered_Competition` REAL,
    `School_Colors` TEXT,
    PRIMARY KEY (`School_ID`)
);

DROP TABLE IF EXISTS `school_player`.`school_details`;
CREATE TABLE `school_player`.`school_details` (
    `School_ID` INT,
    `Nickname` TEXT,
    `Colors` TEXT,
    `League` TEXT,
    `Class` TEXT,
    `Division` TEXT,
    PRIMARY KEY (`School_ID`),
    FOREIGN KEY (`School_ID`) REFERENCES `school_player`.`school` (`School_ID`)
);

DROP TABLE IF EXISTS `school_player`.`school_performance`;
CREATE TABLE `school_player`.`school_performance` (
    `School_Id` INT,
    `School_Year` VARCHAR(50),
    `Class_A` TEXT,
    `Class_AA` TEXT,
    PRIMARY KEY (`School_Id`, `School_Year`),
    FOREIGN KEY (`School_Id`) REFERENCES `school_player`.`school` (`School_ID`)
);

DROP TABLE IF EXISTS `school_player`.`player`;
CREATE TABLE `school_player`.`player` (
    `Player_ID` INT,
    `Player` TEXT,
    `Team` TEXT,
    `Age` INT,
    `Position` TEXT,
    `School_ID` INT,
    PRIMARY KEY (`Player_ID`),
    FOREIGN KEY (`School_ID`) REFERENCES `school_player`.`school` (`School_ID`)
);
