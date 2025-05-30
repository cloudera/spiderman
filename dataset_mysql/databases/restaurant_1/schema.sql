-- Dialect: mysql | Database: restaurant_1 | Table Count: 5

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

CREATE TABLE `restaurant_1`.`Restaurant_Type` (
    `ResTypeID` INTEGER,
    `ResTypeName` VARCHAR(40),
    `ResTypeDescription` VARCHAR(100),
    PRIMARY KEY (`ResTypeID`)
);

CREATE TABLE `restaurant_1`.`Restaurant` (
    `ResID` INTEGER,
    `ResName` VARCHAR(100),
    `Address` VARCHAR(100),
    `Rating` INTEGER,
    PRIMARY KEY (`ResID`)
);

CREATE TABLE `restaurant_1`.`Type_Of_Restaurant` (
    `ResID` INTEGER,
    `ResTypeID` INTEGER,
    FOREIGN KEY (`ResTypeID`) REFERENCES `restaurant_1`.`Restaurant_Type` (`ResTypeID`),
    FOREIGN KEY (`ResID`) REFERENCES `restaurant_1`.`Restaurant` (`ResID`)
);

CREATE TABLE `restaurant_1`.`Visits_Restaurant` (
    `StuID` INTEGER,
    `ResID` INTEGER,
    `Time` DATETIME,
    `Spent` FLOAT,
    FOREIGN KEY (`ResID`) REFERENCES `restaurant_1`.`Restaurant` (`ResID`),
    FOREIGN KEY (`StuID`) REFERENCES `restaurant_1`.`Student` (`StuID`)
);
