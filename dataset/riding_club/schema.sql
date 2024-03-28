-- Dialect: MySQL | Database: riding_club | Table Count: 5

CREATE DATABASE IF NOT EXISTS `riding_club`;

DROP TABLE IF EXISTS `riding_club`.`player`;
CREATE TABLE `riding_club`.`player` (
    `Player_ID` INT,
    `Sponsor_name` TEXT,
    `Player_name` TEXT,
    `Gender` TEXT,
    `Residence` TEXT,
    `Occupation` TEXT,
    `Votes` INT,
    `Rank` TEXT,
    PRIMARY KEY (`Player_ID`)
);

DROP TABLE IF EXISTS `riding_club`.`club`;
CREATE TABLE `riding_club`.`club` (
    `Club_ID` INT,
    `Club_name` TEXT,
    `Region` TEXT,
    `Start_year` INT,
    PRIMARY KEY (`Club_ID`)
);

DROP TABLE IF EXISTS `riding_club`.`coach`;
CREATE TABLE `riding_club`.`coach` (
    `Coach_ID` INT,
    `Coach_name` TEXT,
    `Gender` TEXT,
    `Club_ID` INT,
    `Rank` INT,
    PRIMARY KEY (`Coach_ID`),
    FOREIGN KEY (`Club_ID`) REFERENCES `riding_club`.`club` (`Club_ID`)
);

DROP TABLE IF EXISTS `riding_club`.`player_coach`;
CREATE TABLE `riding_club`.`player_coach` (
    `Player_ID` INT,
    `Coach_ID` INT,
    `Starting_year` INT,
    PRIMARY KEY (`Player_ID`, `Coach_ID`),
    FOREIGN KEY (`Coach_ID`) REFERENCES `riding_club`.`coach` (`Coach_ID`),
    FOREIGN KEY (`Player_ID`) REFERENCES `riding_club`.`player` (`Player_ID`)
);

DROP TABLE IF EXISTS `riding_club`.`match_result`;
CREATE TABLE `riding_club`.`match_result` (
    `Rank` INT,
    `Club_ID` INT,
    `Gold` INT,
    `Big_Silver` INT,
    `Small_Silver` INT,
    `Bronze` INT,
    `Points` INT,
    PRIMARY KEY (`Rank`, `Club_ID`),
    FOREIGN KEY (`Club_ID`) REFERENCES `riding_club`.`club` (`Club_ID`)
);
