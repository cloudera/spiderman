-- Dialect: MySQL | Database: entertainment_awards | Table Count: 3

CREATE DATABASE IF NOT EXISTS `entertainment_awards`;

DROP TABLE IF EXISTS `entertainment_awards`.`festival_detail`;
CREATE TABLE `entertainment_awards`.`festival_detail` (
    `Festival_ID` INT,
    `Festival_Name` TEXT,
    `Chair_Name` TEXT,
    `Location` TEXT,
    `Year` INT,
    `Num_of_Audience` INT,
    PRIMARY KEY (`Festival_ID`)
);

DROP TABLE IF EXISTS `entertainment_awards`.`artwork`;
CREATE TABLE `entertainment_awards`.`artwork` (
    `Artwork_ID` INT,
    `Type` TEXT,
    `Name` TEXT,
    PRIMARY KEY (`Artwork_ID`)
);

DROP TABLE IF EXISTS `entertainment_awards`.`nomination`;
CREATE TABLE `entertainment_awards`.`nomination` (
    `Artwork_ID` INT,
    `Festival_ID` INT,
    `Result` TEXT,
    PRIMARY KEY (`Artwork_ID`, `Festival_ID`),
    FOREIGN KEY (`Festival_ID`) REFERENCES `entertainment_awards`.`festival_detail` (`Festival_ID`),
    FOREIGN KEY (`Artwork_ID`) REFERENCES `entertainment_awards`.`artwork` (`Artwork_ID`)
);
