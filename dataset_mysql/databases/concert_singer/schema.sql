-- Dialect: mysql | Database: concert_singer | Table Count: 4

CREATE TABLE `concert_singer`.`stadium` (
    `Stadium_ID` INT,
    `Location` TEXT,
    `Name` TEXT,
    `Capacity` INT,
    `Highest` INT,
    `Lowest` INT,
    `Average` INT,
    PRIMARY KEY (`Stadium_ID`)
);

CREATE TABLE `concert_singer`.`singer` (
    `Singer_ID` INT,
    `Name` TEXT,
    `Country` TEXT,
    `Song_Name` TEXT,
    `Song_release_year` TEXT,
    `Age` INT,
    `Is_male` CHAR(1),
    PRIMARY KEY (`Singer_ID`)
);

CREATE TABLE `concert_singer`.`concert` (
    `concert_ID` INT,
    `concert_Name` TEXT,
    `Theme` TEXT,
    `Stadium_ID` INT,
    `Year` TEXT,
    PRIMARY KEY (`concert_ID`),
    FOREIGN KEY (`Stadium_ID`) REFERENCES `concert_singer`.`stadium` (`Stadium_ID`)
);

CREATE TABLE `concert_singer`.`singer_in_concert` (
    `concert_ID` INT,
    `Singer_ID` INT,
    PRIMARY KEY (`concert_ID`, `Singer_ID`),
    FOREIGN KEY (`Singer_ID`) REFERENCES `concert_singer`.`singer` (`Singer_ID`),
    FOREIGN KEY (`concert_ID`) REFERENCES `concert_singer`.`concert` (`concert_ID`)
);
