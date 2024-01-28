CREATE DATABASE IF NOT EXISTS `sports_competition`;

drop table if exists `sports_competition`.`club`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`club` (
    `Club_ID` INT,
    `name` STRING,
    `Region` STRING,
    `Start_year` STRING,
    PRIMARY KEY (`Club_ID`) DISABLE NOVALIDATE
);

drop table if exists `sports_competition`.`club_rank`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`club_rank` (
    `Rank` DOUBLE,
    `Club_ID` INT,
    `Gold` DOUBLE,
    `Silver` DOUBLE,
    `Bronze` DOUBLE,
    `Total` DOUBLE,
    PRIMARY KEY (`Rank`, `Club_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
);

drop table if exists `sports_competition`.`player`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`player` (
    `Player_ID` INT,
    `name` STRING,
    `Position` STRING,
    `Club_ID` INT,
    `Apps` DOUBLE,
    `Tries` DOUBLE,
    `Goals` STRING,
    `Points` DOUBLE,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
);

drop table if exists `sports_competition`.`competition`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`competition` (
    `Competition_ID` INT,
    `Year` DOUBLE,
    `Competition_type` STRING,
    `Country` STRING,
    PRIMARY KEY (`Competition_ID`) DISABLE NOVALIDATE
);

drop table if exists `sports_competition`.`competition_result`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`competition_result` (
    `Competition_ID` INT,
    `Club_ID_1` INT,
    `Club_ID_2` INT,
    `Score` STRING,
    PRIMARY KEY (`Competition_ID`, `Club_ID_1`, `Club_ID_2`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Competition_ID`) REFERENCES `sports_competition`.`competition` (`Competition_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID_2`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID_1`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
);
