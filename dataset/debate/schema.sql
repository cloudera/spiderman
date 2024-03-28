-- Dialect: MySQL | Database: debate | Table Count: 3

CREATE DATABASE IF NOT EXISTS `debate`;

DROP TABLE IF EXISTS `debate`.`people`;
CREATE TABLE `debate`.`people` (
    `People_ID` INT,
    `District` TEXT,
    `Name` TEXT,
    `Party` TEXT,
    `Age` INT,
    PRIMARY KEY (`People_ID`)
);

DROP TABLE IF EXISTS `debate`.`debate`;
CREATE TABLE `debate`.`debate` (
    `Debate_ID` INT,
    `Date` TEXT,
    `Venue` TEXT,
    `Num_of_Audience` INT,
    PRIMARY KEY (`Debate_ID`)
);

DROP TABLE IF EXISTS `debate`.`debate_people`;
CREATE TABLE `debate`.`debate_people` (
    `Debate_ID` INT,
    `Affirmative` INT,
    `Negative` INT,
    `If_Affirmative_Win` BOOL,
    PRIMARY KEY (`Debate_ID`, `Affirmative`, `Negative`),
    FOREIGN KEY (`Negative`) REFERENCES `debate`.`people` (`People_ID`),
    FOREIGN KEY (`Affirmative`) REFERENCES `debate`.`people` (`People_ID`),
    FOREIGN KEY (`Debate_ID`) REFERENCES `debate`.`debate` (`Debate_ID`)
);
