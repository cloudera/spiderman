CREATE DATABASE IF NOT EXISTS `wine_1`;

drop table if exists `wine_1`.`grapes`;
CREATE TABLE IF NOT EXISTS `wine_1`.`grapes` (
    `ID` INT,
    `Grape` STRING,
    `Color` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    UNIQUE (`Grape`) DISABLE NOVALIDATE
);

drop table if exists `wine_1`.`appellations`;
CREATE TABLE IF NOT EXISTS `wine_1`.`appellations` (
    `No` INT,
    `Appelation` STRING,
    `County` STRING,
    `State` STRING,
    `Area` STRING,
    `isAVA` STRING,
    PRIMARY KEY (`No`) DISABLE NOVALIDATE,
    UNIQUE (`Appelation`) DISABLE NOVALIDATE
);

drop table if exists `wine_1`.`wine`;
CREATE TABLE IF NOT EXISTS `wine_1`.`wine` (
    `No` INT,
    `Grape` STRING,
    `Winery` STRING,
    `Appelation` STRING,
    `State` STRING,
    `Name` STRING,
    `Year` INT,
    `Price` INT,
    `Score` INT,
    `Cases` INT,
    `Drink` STRING,
    FOREIGN KEY (`Appelation`) REFERENCES `wine_1`.`appellations` (`Appelation`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Grape`) REFERENCES `wine_1`.`grapes` (`Grape`) DISABLE NOVALIDATE
);
