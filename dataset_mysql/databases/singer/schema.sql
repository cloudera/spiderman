-- Dialect: mysql | Database: singer | Table Count: 2

CREATE TABLE `singer`.`singer` (
    `Singer_ID` INT,
    `Name` TEXT,
    `Birth_Year` REAL,
    `Net_Worth_Millions` REAL,
    `Citizenship` TEXT,
    PRIMARY KEY (`Singer_ID`)
);

CREATE TABLE `singer`.`song` (
    `Song_ID` INT,
    `Title` TEXT,
    `Singer_ID` INT,
    `Sales` REAL,
    `Highest_Position` REAL,
    PRIMARY KEY (`Song_ID`),
    FOREIGN KEY (`Singer_ID`) REFERENCES `singer`.`singer` (`Singer_ID`)
);
