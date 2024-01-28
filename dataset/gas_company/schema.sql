CREATE DATABASE IF NOT EXISTS `gas_company`;

drop table if exists `gas_company`.`company`;
CREATE TABLE IF NOT EXISTS `gas_company`.`company` (
    `Company_ID` INT,
    `Rank` INT,
    `Company` STRING,
    `Headquarters` STRING,
    `Main_Industry` STRING,
    `Sales_billion` DOUBLE,
    `Profits_billion` DOUBLE,
    `Assets_billion` DOUBLE,
    `Market_Value` DOUBLE,
    PRIMARY KEY (`Company_ID`) DISABLE NOVALIDATE
);

drop table if exists `gas_company`.`gas_station`;
CREATE TABLE IF NOT EXISTS `gas_company`.`gas_station` (
    `Station_ID` INT,
    `Open_Year` INT,
    `Location` STRING,
    `Manager_Name` STRING,
    `Vice_Manager_Name` STRING,
    `Representative_Name` STRING,
    PRIMARY KEY (`Station_ID`) DISABLE NOVALIDATE
);

drop table if exists `gas_company`.`station_company`;
CREATE TABLE IF NOT EXISTS `gas_company`.`station_company` (
    `Station_ID` INT,
    `Company_ID` INT,
    `Rank_of_the_Year` INT,
    PRIMARY KEY (`Station_ID`, `Company_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Company_ID`) REFERENCES `gas_company`.`company` (`Company_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Station_ID`) REFERENCES `gas_company`.`gas_station` (`Station_ID`) DISABLE NOVALIDATE
);
