-- Dialect: mysql | Database: ship_1 | Table Count: 2

CREATE TABLE `ship_1`.`Ship` (
    `Ship_ID` INT,
    `Name` TEXT,
    `Type` TEXT,
    `Built_Year` REAL,
    `Class` TEXT,
    `Flag` TEXT,
    PRIMARY KEY (`Ship_ID`)
);

CREATE TABLE `ship_1`.`captain` (
    `Captain_ID` INT,
    `Name` TEXT,
    `Ship_ID` INT,
    `age` TEXT,
    `Class` TEXT,
    `Rank` TEXT,
    PRIMARY KEY (`Captain_ID`),
    FOREIGN KEY (`Ship_ID`) REFERENCES `ship_1`.`Ship` (`Ship_ID`)
);
