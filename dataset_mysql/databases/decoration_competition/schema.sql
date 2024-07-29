-- Dialect: MySQL | Database: decoration_competition | Table Count: 3

CREATE DATABASE IF NOT EXISTS `decoration_competition`;

DROP TABLE IF EXISTS `decoration_competition`.`college`;
CREATE TABLE `decoration_competition`.`college` (
    `College_ID` INT,
    `Name` TEXT,
    `Leader_Name` TEXT,
    `College_Location` TEXT,
    PRIMARY KEY (`College_ID`)
);

DROP TABLE IF EXISTS `decoration_competition`.`member`;
CREATE TABLE `decoration_competition`.`member` (
    `Member_ID` INT,
    `Name` TEXT,
    `Country` TEXT,
    `College_ID` INT,
    PRIMARY KEY (`Member_ID`),
    FOREIGN KEY (`College_ID`) REFERENCES `decoration_competition`.`college` (`College_ID`)
);

DROP TABLE IF EXISTS `decoration_competition`.`round`;
CREATE TABLE `decoration_competition`.`round` (
    `Round_ID` INT,
    `Member_ID` INT,
    `Decoration_Theme` TEXT,
    `Rank_in_Round` INT,
    PRIMARY KEY (`Round_ID`, `Member_ID`),
    FOREIGN KEY (`Member_ID`) REFERENCES `decoration_competition`.`member` (`Member_ID`)
);
