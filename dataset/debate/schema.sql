CREATE DATABASE IF NOT EXISTS `debate`;

drop table if exists `debate`.`people`;
CREATE TABLE IF NOT EXISTS `debate`.`people` (
    `People_ID` INT,
    `District` STRING,
    `Name` STRING,
    `Party` STRING,
    `Age` INT,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
);

drop table if exists `debate`.`debate`;
CREATE TABLE IF NOT EXISTS `debate`.`debate` (
    `Debate_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Num_of_Audience` INT,
    PRIMARY KEY (`Debate_ID`) DISABLE NOVALIDATE
);

drop table if exists `debate`.`debate_people`;
CREATE TABLE IF NOT EXISTS `debate`.`debate_people` (
    `Debate_ID` INT,
    `Affirmative` INT,
    `Negative` INT,
    `If_Affirmative_Win` BOOLEAN,
    PRIMARY KEY (`Debate_ID`, `Affirmative`, `Negative`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Negative`) REFERENCES `debate`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Affirmative`) REFERENCES `debate`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Debate_ID`) REFERENCES `debate`.`debate` (`Debate_ID`) DISABLE NOVALIDATE
);
