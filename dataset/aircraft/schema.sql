-- Dialect: MySQL | Database: aircraft | Table Count: 5

CREATE DATABASE IF NOT EXISTS `aircraft`;

DROP TABLE IF EXISTS `aircraft`.`pilot`;
CREATE TABLE `aircraft`.`pilot` (
    `Pilot_Id` INT(11) NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    `Age` INT(11) NOT NULL,
    PRIMARY KEY (`Pilot_Id`)
);

DROP TABLE IF EXISTS `aircraft`.`aircraft`;
CREATE TABLE `aircraft`.`aircraft` (
    `Aircraft_ID` INT(11) NOT NULL,
    `Aircraft` VARCHAR(50) NOT NULL,
    `Description` VARCHAR(50) NOT NULL,
    `Max_Gross_Weight` VARCHAR(50) NOT NULL,
    `Total_disk_area` VARCHAR(50) NOT NULL,
    `Max_disk_Loading` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`Aircraft_ID`)
);

DROP TABLE IF EXISTS `aircraft`.`match`;
CREATE TABLE `aircraft`.`match` (
    `Round` REAL,
    `Location` TEXT,
    `Country` TEXT,
    `Date` TEXT,
    `Fastest_Qualifying` TEXT,
    `Winning_Pilot` INT,
    `Winning_Aircraft` INT,
    PRIMARY KEY (`Round`),
    FOREIGN KEY (`Winning_Pilot`) REFERENCES `aircraft`.`pilot` (`Pilot_Id`),
    FOREIGN KEY (`Winning_Aircraft`) REFERENCES `aircraft`.`aircraft` (`Aircraft_ID`)
);

DROP TABLE IF EXISTS `aircraft`.`airport`;
CREATE TABLE `aircraft`.`airport` (
    `Airport_ID` INT,
    `Airport_Name` TEXT,
    `Total_Passengers` REAL,
    `%_Change_2007` TEXT,
    `International_Passengers` REAL,
    `Domestic_Passengers` REAL,
    `Transit_Passengers` REAL,
    `Aircraft_Movements` REAL,
    `Freight_Metric_Tonnes` REAL,
    PRIMARY KEY (`Airport_ID`)
);

DROP TABLE IF EXISTS `aircraft`.`airport_aircraft`;
CREATE TABLE `aircraft`.`airport_aircraft` (
    `ID` INT,
    `Airport_ID` INT,
    `Aircraft_ID` INT,
    PRIMARY KEY (`Airport_ID`, `Aircraft_ID`),
    FOREIGN KEY (`Aircraft_ID`) REFERENCES `aircraft`.`aircraft` (`Aircraft_ID`),
    FOREIGN KEY (`Airport_ID`) REFERENCES `aircraft`.`airport` (`Airport_ID`)
);
