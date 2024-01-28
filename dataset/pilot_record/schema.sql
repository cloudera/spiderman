CREATE DATABASE IF NOT EXISTS `pilot_record`;

drop table if exists `pilot_record`.`aircraft`;
CREATE TABLE IF NOT EXISTS `pilot_record`.`aircraft` (
    `Aircraft_ID` INT,
    `Order_Year` INT,
    `Manufacturer` STRING,
    `Model` STRING,
    `Fleet_Series` STRING,
    `Powertrain` STRING,
    `Fuel_Propulsion` STRING,
    PRIMARY KEY (`Aircraft_ID`) DISABLE NOVALIDATE
);

drop table if exists `pilot_record`.`pilot`;
CREATE TABLE IF NOT EXISTS `pilot_record`.`pilot` (
    `Pilot_ID` INT,
    `Pilot_name` STRING,
    `Rank` INT,
    `Age` INT,
    `Nationality` STRING,
    `Position` STRING,
    `Join_Year` INT,
    `Team` STRING,
    PRIMARY KEY (`Pilot_ID`) DISABLE NOVALIDATE
);

drop table if exists `pilot_record`.`pilot_record`;
CREATE TABLE IF NOT EXISTS `pilot_record`.`pilot_record` (
    `Record_ID` INT,
    `Pilot_ID` INT,
    `Aircraft_ID` INT,
    `Date` STRING,
    PRIMARY KEY (`Pilot_ID`, `Aircraft_ID`, `Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Aircraft_ID`) REFERENCES `pilot_record`.`aircraft` (`Aircraft_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Pilot_ID`) REFERENCES `pilot_record`.`pilot` (`Pilot_ID`) DISABLE NOVALIDATE
);
