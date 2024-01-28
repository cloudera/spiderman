CREATE DATABASE IF NOT EXISTS `train_station`;

drop table if exists `train_station`.`station`;
CREATE TABLE IF NOT EXISTS `train_station`.`station` (
    `Station_ID` INT,
    `Name` STRING,
    `Annual_entry_exit` DOUBLE,
    `Annual_interchanges` DOUBLE,
    `Total_Passengers` DOUBLE,
    `Location` STRING,
    `Main_Services` STRING,
    `Number_of_Platforms` INT,
    PRIMARY KEY (`Station_ID`) DISABLE NOVALIDATE
);

drop table if exists `train_station`.`train`;
CREATE TABLE IF NOT EXISTS `train_station`.`train` (
    `Train_ID` INT,
    `Name` STRING,
    `Time` STRING,
    `Service` STRING,
    PRIMARY KEY (`Train_ID`) DISABLE NOVALIDATE
);

drop table if exists `train_station`.`train_station`;
CREATE TABLE IF NOT EXISTS `train_station`.`train_station` (
    `Train_ID` INT,
    `Station_ID` INT,
    PRIMARY KEY (`Train_ID`, `Station_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Station_ID`) REFERENCES `train_station`.`station` (`Station_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Train_ID`) REFERENCES `train_station`.`train` (`Train_ID`) DISABLE NOVALIDATE
);
