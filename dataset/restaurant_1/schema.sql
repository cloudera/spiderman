-- Dialect: MySQL | Database: restaurant_1 | Table Count: 5

CREATE DATABASE IF NOT EXISTS `restaurant_1`;

DROP TABLE IF EXISTS `restaurant_1`.`Student`;
CREATE TABLE `restaurant_1`.`Student` (
    `StuID` INTEGER,
    `LName` VARCHAR(12),
    `Fname` VARCHAR(12),
    `Age` INTEGER,
    `Sex` VARCHAR(1),
    `Major` INTEGER,
    `Advisor` INTEGER,
    `city_code` VARCHAR(3),
    PRIMARY KEY (`StuID`)
);

DROP TABLE IF EXISTS `restaurant_1`.`Restaurant_Type`;
CREATE TABLE `restaurant_1`.`Restaurant_Type` (
    `ResTypeID` INTEGER,
    `ResTypeName` VARCHAR(40),
    `ResTypeDescription` VARCHAR(100),
    PRIMARY KEY (`ResTypeID`)
);

DROP TABLE IF EXISTS `restaurant_1`.`Restaurant`;
CREATE TABLE `restaurant_1`.`Restaurant` (
    `ResID` INTEGER,
    `ResName` VARCHAR(100),
    `Address` VARCHAR(100),
    `Rating` INTEGER,
    PRIMARY KEY (`ResID`)
);

DROP TABLE IF EXISTS `restaurant_1`.`Type_Of_Restaurant`;
CREATE TABLE `restaurant_1`.`Type_Of_Restaurant` (
    `ResID` INTEGER,
    `ResTypeID` INTEGER,
    FOREIGN KEY (`ResTypeID`) REFERENCES `restaurant_1`.`Restaurant_Type` (`ResTypeID`),
    FOREIGN KEY (`ResID`) REFERENCES `restaurant_1`.`Restaurant` (`ResID`)
);

DROP TABLE IF EXISTS `restaurant_1`.`Visits_Restaurant`;
CREATE TABLE `restaurant_1`.`Visits_Restaurant` (
    `StuID` INTEGER,
    `ResID` INTEGER,
    `Time` TIMESTAMP,
    `Spent` FLOAT,
    FOREIGN KEY (`ResID`) REFERENCES `restaurant_1`.`Restaurant` (`ResID`),
    FOREIGN KEY (`StuID`) REFERENCES `restaurant_1`.`Student` (`StuID`)
);
