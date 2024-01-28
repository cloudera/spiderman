CREATE DATABASE IF NOT EXISTS `game_1`;

drop table if exists `game_1`.`Student`;
CREATE TABLE IF NOT EXISTS `game_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
);

drop table if exists `game_1`.`Video_Games`;
CREATE TABLE IF NOT EXISTS `game_1`.`Video_Games` (
    `GameID` INT,
    `GName` STRING,
    `GType` STRING,
    PRIMARY KEY (`GameID`) DISABLE NOVALIDATE
);

drop table if exists `game_1`.`Plays_Games`;
CREATE TABLE IF NOT EXISTS `game_1`.`Plays_Games` (
    `StuID` INT,
    `GameID` INT,
    `Hours_Played` INT,
    FOREIGN KEY (`StuID`) REFERENCES `game_1`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`GameID`) REFERENCES `game_1`.`Video_Games` (`GameID`) DISABLE NOVALIDATE
);

drop table if exists `game_1`.`SportsInfo`;
CREATE TABLE IF NOT EXISTS `game_1`.`SportsInfo` (
    `StuID` INT,
    `SportName` STRING,
    `HoursPerWeek` INT,
    `GamesPlayed` INT,
    `OnScholarship` STRING,
    FOREIGN KEY (`StuID`) REFERENCES `game_1`.`Student` (`StuID`) DISABLE NOVALIDATE
);
