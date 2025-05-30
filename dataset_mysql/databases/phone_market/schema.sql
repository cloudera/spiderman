-- Dialect: mysql | Database: phone_market | Table Count: 3

CREATE TABLE `phone_market`.`phone` (
    `Name` TEXT,
    `Phone_ID` INT,
    `Memory_in_G` INT,
    `Carrier` TEXT,
    `Price` REAL,
    PRIMARY KEY (`Phone_ID`)
);

CREATE TABLE `phone_market`.`market` (
    `Market_ID` INT,
    `District` TEXT,
    `Num_of_employees` INT,
    `Num_of_shops` REAL,
    `Ranking` INT,
    PRIMARY KEY (`Market_ID`)
);

CREATE TABLE `phone_market`.`phone_market` (
    `Market_ID` INT,
    `Phone_ID` INT,
    `Num_of_stock` INT,
    PRIMARY KEY (`Market_ID`, `Phone_ID`),
    FOREIGN KEY (`Phone_ID`) REFERENCES `phone_market`.`phone` (`Phone_ID`),
    FOREIGN KEY (`Market_ID`) REFERENCES `phone_market`.`market` (`Market_ID`)
);
