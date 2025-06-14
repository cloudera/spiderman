-- Dialect: mysql | Database: railway | Table Count: 4

CREATE TABLE `railway`.`railway` (
    `Railway_ID` INT,
    `Railway` TEXT,
    `Builder` TEXT,
    `Built` TEXT,
    `Wheels` TEXT,
    `Location` TEXT,
    `ObjectNumber` TEXT,
    PRIMARY KEY (`Railway_ID`)
);

CREATE TABLE `railway`.`train` (
    `Train_ID` INT,
    `Train_Num` TEXT,
    `Name` TEXT,
    `From` TEXT,
    `Arrival` TEXT,
    `Railway_ID` INT,
    PRIMARY KEY (`Train_ID`),
    FOREIGN KEY (`Railway_ID`) REFERENCES `railway`.`railway` (`Railway_ID`)
);

CREATE TABLE `railway`.`manager` (
    `Manager_ID` INT,
    `Name` TEXT,
    `Country` TEXT,
    `Working_year_starts` TEXT,
    `Age` INT,
    `Level` INT,
    PRIMARY KEY (`Manager_ID`)
);

CREATE TABLE `railway`.`railway_manage` (
    `Railway_ID` INT,
    `Manager_ID` INT,
    `From_Year` TEXT,
    PRIMARY KEY (`Railway_ID`, `Manager_ID`),
    FOREIGN KEY (`Railway_ID`) REFERENCES `railway`.`railway` (`Railway_ID`),
    FOREIGN KEY (`Manager_ID`) REFERENCES `railway`.`manager` (`Manager_ID`)
);
