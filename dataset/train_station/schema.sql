-- Dialect: MySQL | Database: train_station | Table Count: 3

CREATE DATABASE IF NOT EXISTS `train_station`;

DROP TABLE IF EXISTS `train_station`.`station`;
CREATE TABLE `train_station`.`station` (
    `Station_ID` INT,
    `Name` TEXT,
    `Annual_entry_exit` REAL,
    `Annual_interchanges` REAL,
    `Total_Passengers` REAL,
    `Location` TEXT,
    `Main_Services` TEXT,
    `Number_of_Platforms` INT,
    PRIMARY KEY (`Station_ID`)
);

DROP TABLE IF EXISTS `train_station`.`train`;
CREATE TABLE `train_station`.`train` (
    `Train_ID` INT,
    `Name` TEXT,
    `Time` TEXT,
    `Service` TEXT,
    PRIMARY KEY (`Train_ID`)
);

DROP TABLE IF EXISTS `train_station`.`train_station`;
CREATE TABLE `train_station`.`train_station` (
    `Train_ID` INT,
    `Station_ID` INT,
    PRIMARY KEY (`Train_ID`, `Station_ID`),
    FOREIGN KEY (`Station_ID`) REFERENCES `train_station`.`station` (`Station_ID`),
    FOREIGN KEY (`Train_ID`) REFERENCES `train_station`.`train` (`Train_ID`)
);
