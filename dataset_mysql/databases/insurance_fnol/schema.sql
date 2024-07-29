-- Dialect: MySQL | Database: insurance_fnol | Table Count: 7

CREATE DATABASE IF NOT EXISTS `insurance_fnol`;

DROP TABLE IF EXISTS `insurance_fnol`.`Customers`;
CREATE TABLE `insurance_fnol`.`Customers` (
    `Customer_ID` INTEGER NOT NULL,
    `Customer_name` VARCHAR(40),
    PRIMARY KEY (`Customer_ID`)
);

DROP TABLE IF EXISTS `insurance_fnol`.`Services`;
CREATE TABLE `insurance_fnol`.`Services` (
    `Service_ID` INTEGER NOT NULL,
    `Service_name` VARCHAR(40),
    PRIMARY KEY (`Service_ID`)
);

DROP TABLE IF EXISTS `insurance_fnol`.`Available_Policies`;
CREATE TABLE `insurance_fnol`.`Available_Policies` (
    `Policy_ID` INTEGER NOT NULL,
    `policy_type_code` VARCHAR(20),
    `Customer_Phone` VARCHAR(255),
    PRIMARY KEY (`Policy_ID`),
    UNIQUE (`Policy_ID`)
);

DROP TABLE IF EXISTS `insurance_fnol`.`Customers_Policies`;
CREATE TABLE `insurance_fnol`.`Customers_Policies` (
    `Customer_ID` INTEGER NOT NULL,
    `Policy_ID` INTEGER NOT NULL,
    `Date_Opened` DATE,
    `Date_Closed` DATE,
    PRIMARY KEY (`Customer_ID`, `Policy_ID`),
    FOREIGN KEY (`Policy_ID`) REFERENCES `insurance_fnol`.`Available_Policies` (`Policy_ID`),
    FOREIGN KEY (`Customer_ID`) REFERENCES `insurance_fnol`.`Customers` (`Customer_ID`)
);

DROP TABLE IF EXISTS `insurance_fnol`.`First_Notification_of_Loss`;
CREATE TABLE `insurance_fnol`.`First_Notification_of_Loss` (
    `FNOL_ID` INTEGER NOT NULL,
    `Customer_ID` INTEGER NOT NULL,
    `Policy_ID` INTEGER NOT NULL,
    `Service_ID` INTEGER NOT NULL,
    PRIMARY KEY (`FNOL_ID`),
    FOREIGN KEY (`Customer_ID`, `Policy_ID`) REFERENCES `insurance_fnol`.`Customers_Policies` (`Customer_ID`, `Policy_ID`),
    FOREIGN KEY (`Service_ID`) REFERENCES `insurance_fnol`.`Services` (`Service_ID`),
    UNIQUE (`FNOL_ID`)
);

DROP TABLE IF EXISTS `insurance_fnol`.`Claims`;
CREATE TABLE `insurance_fnol`.`Claims` (
    `Claim_ID` INTEGER NOT NULL,
    `FNOL_ID` INTEGER NOT NULL,
    `Effective_Date` DATE,
    PRIMARY KEY (`Claim_ID`),
    FOREIGN KEY (`FNOL_ID`) REFERENCES `insurance_fnol`.`First_Notification_of_Loss` (`FNOL_ID`),
    UNIQUE (`Claim_ID`)
);

DROP TABLE IF EXISTS `insurance_fnol`.`Settlements`;
CREATE TABLE `insurance_fnol`.`Settlements` (
    `Settlement_ID` INTEGER NOT NULL,
    `Claim_ID` INTEGER,
    `Effective_Date` DATE,
    `Settlement_Amount` REAL,
    PRIMARY KEY (`Settlement_ID`),
    FOREIGN KEY (`Claim_ID`) REFERENCES `insurance_fnol`.`Claims` (`Claim_ID`),
    UNIQUE (`Settlement_ID`)
);
