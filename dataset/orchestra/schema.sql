-- Dialect: MySQL | Database: orchestra | Table Count: 4

CREATE DATABASE IF NOT EXISTS `orchestra`;

DROP TABLE IF EXISTS `orchestra`.`conductor`;
CREATE TABLE `orchestra`.`conductor` (
    `Conductor_ID` INT,
    `Name` TEXT,
    `Age` INT,
    `Nationality` TEXT,
    `Year_of_Work` INT,
    PRIMARY KEY (`Conductor_ID`)
);

DROP TABLE IF EXISTS `orchestra`.`orchestra`;
CREATE TABLE `orchestra`.`orchestra` (
    `Orchestra_ID` INT,
    `Orchestra` TEXT,
    `Conductor_ID` INT,
    `Record_Company` TEXT,
    `Year_of_Founded` REAL,
    `Major_Record_Format` TEXT,
    PRIMARY KEY (`Orchestra_ID`),
    FOREIGN KEY (`Conductor_ID`) REFERENCES `orchestra`.`conductor` (`Conductor_ID`)
);

DROP TABLE IF EXISTS `orchestra`.`performance`;
CREATE TABLE `orchestra`.`performance` (
    `Performance_ID` INT,
    `Orchestra_ID` INT,
    `Type` TEXT,
    `Date` TEXT,
    `Official_ratings_(millions)` REAL,
    `Weekly_rank` TEXT,
    `Share` TEXT,
    PRIMARY KEY (`Performance_ID`),
    FOREIGN KEY (`Orchestra_ID`) REFERENCES `orchestra`.`orchestra` (`Orchestra_ID`)
);

DROP TABLE IF EXISTS `orchestra`.`show`;
CREATE TABLE `orchestra`.`show` (
    `Show_ID` INT,
    `Performance_ID` INT,
    `If_first_show` VARCHAR(15),
    `Result` TEXT,
    `Attendance` REAL,
    FOREIGN KEY (`Performance_ID`) REFERENCES `orchestra`.`performance` (`Performance_ID`)
);
