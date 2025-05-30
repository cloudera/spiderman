-- Dialect: mysql | Database: election_representative | Table Count: 2

CREATE TABLE `election_representative`.`representative` (
    `Representative_ID` INT,
    `Name` TEXT,
    `State` TEXT,
    `Party` TEXT,
    `Lifespan` TEXT,
    PRIMARY KEY (`Representative_ID`)
);

CREATE TABLE `election_representative`.`election` (
    `Election_ID` INT,
    `Representative_ID` INT,
    `Date` TEXT,
    `Votes` REAL,
    `Vote_Percent` REAL,
    `Seats` REAL,
    `Place` REAL,
    PRIMARY KEY (`Election_ID`),
    FOREIGN KEY (`Representative_ID`) REFERENCES `election_representative`.`representative` (`Representative_ID`)
);
