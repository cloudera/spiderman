-- Dialect: mysql | Database: race_track | Table Count: 2

CREATE TABLE `race_track`.`track` (
    `Track_ID` INT,
    `Name` TEXT,
    `Location` TEXT,
    `Seating` REAL,
    `Year_Opened` REAL,
    PRIMARY KEY (`Track_ID`)
);

CREATE TABLE `race_track`.`race` (
    `Race_ID` INT,
    `Name` TEXT,
    `Class` TEXT,
    `Date` TEXT,
    `Track_ID` INT,
    PRIMARY KEY (`Race_ID`),
    FOREIGN KEY (`Track_ID`) REFERENCES `race_track`.`track` (`Track_ID`)
);
