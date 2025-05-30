-- Dialect: mysql | Database: gymnast | Table Count: 2

CREATE TABLE `gymnast`.`people` (
    `People_ID` INT,
    `Name` TEXT,
    `Age` REAL,
    `Height` REAL,
    `Hometown` TEXT,
    PRIMARY KEY (`People_ID`)
);

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
