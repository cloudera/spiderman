-- Dialect: MySQL | Database: wedding | Table Count: 3

CREATE DATABASE IF NOT EXISTS `wedding`;

DROP TABLE IF EXISTS `wedding`.`people`;
CREATE TABLE `wedding`.`people` (
    `People_ID` INT,
    `Name` TEXT,
    `Country` TEXT,
    `Is_Male` TEXT,
    `Age` INT,
    PRIMARY KEY (`People_ID`)
);

DROP TABLE IF EXISTS `wedding`.`church`;
CREATE TABLE `wedding`.`church` (
    `Church_ID` INT,
    `Name` TEXT,
    `Organized_by` TEXT,
    `Open_Date` INT,
    `Continuation_of` TEXT,
    PRIMARY KEY (`Church_ID`)
);

DROP TABLE IF EXISTS `wedding`.`wedding`;
CREATE TABLE `wedding`.`wedding` (
    `Church_ID` INT,
    `Male_ID` INT,
    `Female_ID` INT,
    `Year` INT,
    PRIMARY KEY (`Church_ID`, `Male_ID`, `Female_ID`),
    FOREIGN KEY (`Female_ID`) REFERENCES `wedding`.`people` (`People_ID`),
    FOREIGN KEY (`Male_ID`) REFERENCES `wedding`.`people` (`People_ID`),
    FOREIGN KEY (`Church_ID`) REFERENCES `wedding`.`church` (`Church_ID`)
);
