-- Dialect: mysql | Database: program_share | Table Count: 4

CREATE TABLE `program_share`.`program` (
    `Program_ID` INT,
    `Name` TEXT,
    `Origin` TEXT,
    `Launch` REAL,
    `Owner` TEXT,
    PRIMARY KEY (`Program_ID`)
);

CREATE TABLE `program_share`.`channel` (
    `Channel_ID` INT,
    `Name` TEXT,
    `Owner` TEXT,
    `Share_in_percent` REAL,
    `Rating_in_percent` REAL,
    PRIMARY KEY (`Channel_ID`)
);

CREATE TABLE `program_share`.`broadcast` (
    `Channel_ID` INT,
    `Program_ID` INT,
    `Time_of_day` TEXT,
    PRIMARY KEY (`Channel_ID`, `Program_ID`),
    FOREIGN KEY (`Program_ID`) REFERENCES `program_share`.`program` (`Program_ID`),
    FOREIGN KEY (`Channel_ID`) REFERENCES `program_share`.`channel` (`Channel_ID`)
);

CREATE TABLE `program_share`.`broadcast_share` (
    `Channel_ID` INT,
    `Program_ID` INT,
    `Date` TEXT,
    `Share_in_percent` REAL,
    PRIMARY KEY (`Channel_ID`, `Program_ID`),
    FOREIGN KEY (`Program_ID`) REFERENCES `program_share`.`program` (`Program_ID`),
    FOREIGN KEY (`Channel_ID`) REFERENCES `program_share`.`channel` (`Channel_ID`)
);
