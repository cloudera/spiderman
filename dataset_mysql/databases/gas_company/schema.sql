-- Dialect: MySQL | Database: gas_company | Table Count: 3

CREATE DATABASE IF NOT EXISTS `gas_company`;

DROP TABLE IF EXISTS `gas_company`.`company`;
CREATE TABLE `gas_company`.`company` (
    `Company_ID` INT,
    `Rank` INT,
    `Company` TEXT,
    `Headquarters` TEXT,
    `Main_Industry` TEXT,
    `Sales_billion` REAL,
    `Profits_billion` REAL,
    `Assets_billion` REAL,
    `Market_Value` REAL,
    PRIMARY KEY (`Company_ID`)
);

DROP TABLE IF EXISTS `gas_company`.`gas_station`;
CREATE TABLE `gas_company`.`gas_station` (
    `Station_ID` INT,
    `Open_Year` INT,
    `Location` TEXT,
    `Manager_Name` TEXT,
    `Vice_Manager_Name` TEXT,
    `Representative_Name` TEXT,
    PRIMARY KEY (`Station_ID`)
);

DROP TABLE IF EXISTS `gas_company`.`station_company`;
CREATE TABLE `gas_company`.`station_company` (
    `Station_ID` INT,
    `Company_ID` INT,
    `Rank_of_the_Year` INT,
    PRIMARY KEY (`Station_ID`, `Company_ID`),
    FOREIGN KEY (`Company_ID`) REFERENCES `gas_company`.`company` (`Company_ID`),
    FOREIGN KEY (`Station_ID`) REFERENCES `gas_company`.`gas_station` (`Station_ID`)
);
