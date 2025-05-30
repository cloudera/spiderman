-- Dialect: mysql | Database: device | Table Count: 3

CREATE TABLE `device`.`device` (
    `Device_ID` INT,
    `Device` TEXT,
    `Carrier` TEXT,
    `Package_Version` TEXT,
    `Applications` TEXT,
    `Software_Platform` TEXT,
    PRIMARY KEY (`Device_ID`)
);

CREATE TABLE `device`.`shop` (
    `Shop_ID` INT,
    `Shop_Name` TEXT,
    `Location` TEXT,
    `Open_Date` TEXT,
    `Open_Year` INT,
    PRIMARY KEY (`Shop_ID`)
);

CREATE TABLE `device`.`stock` (
    `Shop_ID` INT,
    `Device_ID` INT,
    `Quantity` INT,
    PRIMARY KEY (`Shop_ID`, `Device_ID`),
    FOREIGN KEY (`Device_ID`) REFERENCES `device`.`device` (`Device_ID`),
    FOREIGN KEY (`Shop_ID`) REFERENCES `device`.`shop` (`Shop_ID`)
);
