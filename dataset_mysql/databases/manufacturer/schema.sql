-- Dialect: mysql | Database: manufacturer | Table Count: 3

CREATE TABLE `manufacturer`.`manufacturer` (
    `Manufacturer_ID` INT,
    `Open_Year` REAL,
    `Name` TEXT,
    `Num_of_Factories` INT,
    `Num_of_Shops` INT,
    PRIMARY KEY (`Manufacturer_ID`)
);

CREATE TABLE `manufacturer`.`furniture` (
    `Furniture_ID` INT,
    `Name` TEXT,
    `Num_of_Component` INT,
    `Market_Rate` REAL,
    PRIMARY KEY (`Furniture_ID`)
);

CREATE TABLE `manufacturer`.`furniture_manufacte` (
    `Manufacturer_ID` INT,
    `Furniture_ID` INT,
    `Price_in_Dollar` REAL,
    PRIMARY KEY (`Manufacturer_ID`, `Furniture_ID`),
    FOREIGN KEY (`Furniture_ID`) REFERENCES `manufacturer`.`furniture` (`Furniture_ID`),
    FOREIGN KEY (`Manufacturer_ID`) REFERENCES `manufacturer`.`manufacturer` (`Manufacturer_ID`)
);
