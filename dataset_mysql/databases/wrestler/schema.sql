-- Dialect: MySQL | Database: wrestler | Table Count: 2

CREATE DATABASE IF NOT EXISTS `wrestler`;

DROP TABLE IF EXISTS `wrestler`.`wrestler`;
CREATE TABLE `wrestler`.`wrestler` (
    `Wrestler_ID` INT,
    `Name` TEXT,
    `Reign` TEXT,
    `Days_held` TEXT,
    `Location` TEXT,
    `Event` TEXT,
    PRIMARY KEY (`Wrestler_ID`)
);

DROP TABLE IF EXISTS `wrestler`.`Elimination`;
CREATE TABLE `wrestler`.`Elimination` (
    `Elimination_ID` VARCHAR(50),
    `Wrestler_ID` INT,
    `Team` TEXT,
    `Eliminated_By` TEXT,
    `Elimination_Move` TEXT,
    `Time` TEXT,
    PRIMARY KEY (`Elimination_ID`),
    FOREIGN KEY (`Wrestler_ID`) REFERENCES `wrestler`.`wrestler` (`Wrestler_ID`)
);
