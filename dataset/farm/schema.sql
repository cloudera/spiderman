-- Dialect: MySQL | Database: farm | Table Count: 4

CREATE DATABASE IF NOT EXISTS `farm`;

DROP TABLE IF EXISTS `farm`.`city`;
CREATE TABLE `farm`.`city` (
    `City_ID` INT,
    `Official_Name` TEXT,
    `Status` TEXT,
    `Area_km_2` REAL,
    `Population` REAL,
    `Census_Ranking` TEXT,
    PRIMARY KEY (`City_ID`)
);

DROP TABLE IF EXISTS `farm`.`farm`;
CREATE TABLE `farm`.`farm` (
    `Farm_ID` INT,
    `Year` INT,
    `Total_Horses` REAL,
    `Working_Horses` REAL,
    `Total_Cattle` REAL,
    `Oxen` REAL,
    `Bulls` REAL,
    `Cows` REAL,
    `Pigs` REAL,
    `Sheep_and_Goats` REAL,
    PRIMARY KEY (`Farm_ID`)
);

DROP TABLE IF EXISTS `farm`.`farm_competition`;
CREATE TABLE `farm`.`farm_competition` (
    `Competition_ID` INT,
    `Year` INT,
    `Theme` TEXT,
    `Host_city_ID` INT,
    `Hosts` TEXT,
    PRIMARY KEY (`Competition_ID`),
    FOREIGN KEY (`Host_city_ID`) REFERENCES `farm`.`city` (`City_ID`)
);

DROP TABLE IF EXISTS `farm`.`competition_record`;
CREATE TABLE `farm`.`competition_record` (
    `Competition_ID` INT,
    `Farm_ID` INT,
    `Rank` INT,
    PRIMARY KEY (`Competition_ID`, `Farm_ID`),
    FOREIGN KEY (`Farm_ID`) REFERENCES `farm`.`farm` (`Farm_ID`),
    FOREIGN KEY (`Competition_ID`) REFERENCES `farm`.`farm_competition` (`Competition_ID`)
);
