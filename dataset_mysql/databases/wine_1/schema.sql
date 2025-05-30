-- Dialect: mysql | Database: wine_1 | Table Count: 3

CREATE TABLE `wine_1`.`grapes` (
    `ID` INTEGER,
    `Grape` VARCHAR(50),
    `Color` TEXT,
    PRIMARY KEY (`ID`),
    UNIQUE (`Grape`)
);

CREATE TABLE `wine_1`.`appellations` (
    `No` INTEGER,
    `Appelation` VARCHAR(50),
    `County` TEXT,
    `State` TEXT,
    `Area` TEXT,
    `isAVA` TEXT,
    PRIMARY KEY (`No`),
    UNIQUE (`Appelation`)
);

CREATE TABLE `wine_1`.`wine` (
    `No` INTEGER,
    `Grape` VARCHAR(50),
    `Winery` TEXT,
    `Appelation` VARCHAR(50),
    `State` TEXT,
    `Name` TEXT,
    `Year` INTEGER,
    `Price` INTEGER,
    `Score` INTEGER,
    `Cases` INTEGER,
    `Drink` TEXT,
    FOREIGN KEY (`Appelation`) REFERENCES `wine_1`.`appellations` (`Appelation`),
    FOREIGN KEY (`Grape`) REFERENCES `wine_1`.`grapes` (`Grape`)
);
