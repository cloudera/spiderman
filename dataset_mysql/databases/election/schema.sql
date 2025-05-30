-- Dialect: mysql | Database: election | Table Count: 3

CREATE TABLE `election`.`county` (
    `County_Id` INT,
    `County_name` TEXT,
    `Population` REAL,
    `Zip_code` TEXT,
    PRIMARY KEY (`County_Id`)
);

CREATE TABLE `election`.`party` (
    `Party_ID` INT,
    `Year` REAL,
    `Party` TEXT,
    `Governor` TEXT,
    `Lieutenant_Governor` TEXT,
    `Comptroller` TEXT,
    `Attorney_General` TEXT,
    `US_Senate` TEXT,
    PRIMARY KEY (`Party_ID`)
);

CREATE TABLE `election`.`election` (
    `Election_ID` INT,
    `Counties_Represented` TEXT,
    `District` INT,
    `Delegate` TEXT,
    `Party` INT,
    `First_Elected` REAL,
    `Committee` TEXT,
    PRIMARY KEY (`Election_ID`),
    FOREIGN KEY (`District`) REFERENCES `election`.`county` (`County_Id`),
    FOREIGN KEY (`Party`) REFERENCES `election`.`party` (`Party_ID`)
);
