-- Dialect: mysql | Database: soccer_2 | Table Count: 3

CREATE TABLE `soccer_2`.`College` (
    `cName` VARCHAR(20) NOT NULL,
    `state` VARCHAR(2),
    `enr` NUMERIC(5,0),
    PRIMARY KEY (`cName`)
);

CREATE TABLE `soccer_2`.`Player` (
    `pID` NUMERIC(5,0) NOT NULL,
    `pName` VARCHAR(20),
    `yCard` VARCHAR(3),
    `HS` NUMERIC(5,0),
    PRIMARY KEY (`pID`)
);

CREATE TABLE `soccer_2`.`Tryout` (
    `pID` NUMERIC(5,0),
    `cName` VARCHAR(20),
    `pPos` VARCHAR(8),
    `decision` VARCHAR(3),
    PRIMARY KEY (`pID`, `cName`),
    FOREIGN KEY (`cName`) REFERENCES `soccer_2`.`College` (`cName`),
    FOREIGN KEY (`pID`) REFERENCES `soccer_2`.`Player` (`pID`)
);
