CREATE DATABASE IF NOT EXISTS `gymnast`;

drop table if exists `gymnast`.`people`;
CREATE TABLE IF NOT EXISTS `gymnast`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Age` DOUBLE,
    `Height` DOUBLE,
    `Hometown` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
);

drop table if exists `gymnast`.`gymnast`;
CREATE TABLE IF NOT EXISTS `gymnast`.`gymnast` (
    `Gymnast_ID` INT,
    `Floor_Exercise_Points` DOUBLE,
    `Pommel_Horse_Points` DOUBLE,
    `Rings_Points` DOUBLE,
    `Vault_Points` DOUBLE,
    `Parallel_Bars_Points` DOUBLE,
    `Horizontal_Bar_Points` DOUBLE,
    `Total_Points` DOUBLE,
    PRIMARY KEY (`Gymnast_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Gymnast_ID`) REFERENCES `gymnast`.`people` (`People_ID`) DISABLE NOVALIDATE
);
