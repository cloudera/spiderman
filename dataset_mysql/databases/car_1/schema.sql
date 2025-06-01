-- Dialect: mysql | Database: car_1 | Table Count: 6

CREATE TABLE `car_1`.`continents` (
    `ContId` INTEGER,
    `Continent` TEXT,
    PRIMARY KEY (`ContId`)
);

CREATE TABLE `car_1`.`countries` (
    `CountryId` INTEGER,
    `CountryName` TEXT,
    `Continent` INTEGER,
    PRIMARY KEY (`CountryId`),
    FOREIGN KEY (`Continent`) REFERENCES `car_1`.`continents` (`ContId`)
);

CREATE TABLE `car_1`.`car_makers` (
    `Id` INTEGER,
    `Maker` TEXT,
    `FullName` TEXT,
    `Country` INT,
    PRIMARY KEY (`Id`),
    FOREIGN KEY (`Country`) REFERENCES `car_1`.`countries` (`CountryId`)
);

CREATE TABLE `car_1`.`model_list` (
    `ModelId` INTEGER,
    `Maker` INTEGER,
    `Model` VARCHAR(50),
    PRIMARY KEY (`ModelId`),
    FOREIGN KEY (`Maker`) REFERENCES `car_1`.`car_makers` (`Id`),
    UNIQUE (`Model`)
);

CREATE TABLE `car_1`.`car_names` (
    `MakeId` INTEGER,
    `Model` VARCHAR(50),
    `Make` TEXT,
    PRIMARY KEY (`MakeId`),
    FOREIGN KEY (`Model`) REFERENCES `car_1`.`model_list` (`Model`)
);

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
