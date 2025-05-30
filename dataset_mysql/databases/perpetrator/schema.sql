-- Dialect: mysql | Database: perpetrator | Table Count: 2

CREATE TABLE `perpetrator`.`people` (
    `People_ID` INT,
    `Name` TEXT,
    `Height` REAL,
    `Weight` REAL,
    `Home Town` TEXT,
    PRIMARY KEY (`People_ID`)
);

CREATE TABLE `perpetrator`.`perpetrator` (
    `Perpetrator_ID` INT,
    `People_ID` INT,
    `Date` TEXT,
    `Year` REAL,
    `Location` TEXT,
    `Country` TEXT,
    `Killed` INT,
    `Injured` INT,
    PRIMARY KEY (`Perpetrator_ID`),
    FOREIGN KEY (`People_ID`) REFERENCES `perpetrator`.`people` (`People_ID`)
);
