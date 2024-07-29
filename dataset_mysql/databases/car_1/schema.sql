-- Dialect: MySQL | Database: car_1 | Table Count: 6

CREATE DATABASE IF NOT EXISTS `car_1`;

DROP TABLE IF EXISTS `car_1`.`continents`;
CREATE TABLE `car_1`.`continents` (
    `ContId` INTEGER,
    `Continent` TEXT,
    PRIMARY KEY (`ContId`)
);

DROP TABLE IF EXISTS `car_1`.`countries`;
CREATE TABLE `car_1`.`countries` (
    `CountryId` INTEGER,
    `CountryName` TEXT,
    `Continent` INTEGER,
    PRIMARY KEY (`CountryId`),
    FOREIGN KEY (`Continent`) REFERENCES `car_1`.`continents` (`ContId`)
);

DROP TABLE IF EXISTS `car_1`.`car_makers`;
CREATE TABLE `car_1`.`car_makers` (
    `Id` INTEGER,
    `Maker` TEXT,
    `FullName` TEXT,
    `Country` INT,
    PRIMARY KEY (`Id`),
    FOREIGN KEY (`Country`) REFERENCES `car_1`.`countries` (`CountryId`)
);

DROP TABLE IF EXISTS `car_1`.`model_list`;
CREATE TABLE `car_1`.`model_list` (
    `ModelId` INTEGER,
    `Maker` INTEGER,
    `Model` VARCHAR(50),
    PRIMARY KEY (`ModelId`),
    FOREIGN KEY (`Maker`) REFERENCES `car_1`.`car_makers` (`Id`),
    UNIQUE (`Model`)
);

DROP TABLE IF EXISTS `car_1`.`car_names`;
CREATE TABLE `car_1`.`car_names` (
    `MakeId` INTEGER,
    `Model` VARCHAR(20),
    `Make` TEXT,
    PRIMARY KEY (`MakeId`),
    FOREIGN KEY (`Model`) REFERENCES `car_1`.`model_list` (`Model`)
);

DROP TABLE IF EXISTS `car_1`.`cars_data`;
CREATE TABLE `car_1`.`cars_data` (
    `Id` INTEGER,
    `MPG` TEXT,
    `Cylinders` INTEGER,
    `Edispl` REAL,
    `Horsepower` TEXT,
    `Weight` INTEGER,
    `Accelerate` REAL,
    `Year` INTEGER,
    PRIMARY KEY (`Id`),
    FOREIGN KEY (`Id`) REFERENCES `car_1`.`car_names` (`MakeId`)
);
