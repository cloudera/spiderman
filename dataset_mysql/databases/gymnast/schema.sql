-- Dialect: MySQL | Database: gymnast | Table Count: 2

CREATE DATABASE IF NOT EXISTS `gymnast`;

DROP TABLE IF EXISTS `gymnast`.`people`;
CREATE TABLE `gymnast`.`people` (
    `People_ID` INT,
    `Name` TEXT,
    `Age` REAL,
    `Height` REAL,
    `Hometown` TEXT,
    PRIMARY KEY (`People_ID`)
);

DROP TABLE IF EXISTS `gymnast`.`gymnast`;
CREATE TABLE `gymnast`.`gymnast` (
    `Gymnast_ID` INT,
    `Floor_Exercise_Points` REAL,
    `Pommel_Horse_Points` REAL,
    `Rings_Points` REAL,
    `Vault_Points` REAL,
    `Parallel_Bars_Points` REAL,
    `Horizontal_Bar_Points` REAL,
    `Total_Points` REAL,
    PRIMARY KEY (`Gymnast_ID`),
    FOREIGN KEY (`Gymnast_ID`) REFERENCES `gymnast`.`people` (`People_ID`)
);
