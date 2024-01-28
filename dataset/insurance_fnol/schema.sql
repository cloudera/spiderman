CREATE DATABASE IF NOT EXISTS `insurance_fnol`;

drop table if exists `insurance_fnol`.`Customers`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Customers` (
    `Customer_ID` INT NOT NULL,
    `Customer_name` STRING,
    PRIMARY KEY (`Customer_ID`) DISABLE NOVALIDATE
);

drop table if exists `insurance_fnol`.`Services`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Services` (
    `Service_ID` INT NOT NULL,
    `Service_name` STRING,
    PRIMARY KEY (`Service_ID`) DISABLE NOVALIDATE
);

drop table if exists `insurance_fnol`.`Available_Policies`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Available_Policies` (
    `Policy_ID` INT NOT NULL,
    `policy_type_code` CHAR(15),
    `Customer_Phone` STRING,
    PRIMARY KEY (`Policy_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Policy_ID`) DISABLE NOVALIDATE
);

drop table if exists `insurance_fnol`.`Customers_Policies`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Customers_Policies` (
    `Customer_ID` INT NOT NULL,
    `Policy_ID` INT NOT NULL,
    `Date_Opened` DATE,
    `Date_Closed` DATE,
    PRIMARY KEY (`Customer_ID`, `Policy_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Policy_ID`) REFERENCES `insurance_fnol`.`Available_Policies` (`Policy_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_ID`) REFERENCES `insurance_fnol`.`Customers` (`Customer_ID`) DISABLE NOVALIDATE
);

drop table if exists `insurance_fnol`.`First_Notification_of_Loss`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`First_Notification_of_Loss` (
    `FNOL_ID` INT NOT NULL,
    `Customer_ID` INT NOT NULL,
    `Policy_ID` INT NOT NULL,
    `Service_ID` INT NOT NULL,
    PRIMARY KEY (`FNOL_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_ID`, `Policy_ID`) REFERENCES `insurance_fnol`.`Customers_Policies` (`Customer_ID`, `Policy_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Service_ID`) REFERENCES `insurance_fnol`.`Services` (`Service_ID`) DISABLE NOVALIDATE,
    UNIQUE (`FNOL_ID`) DISABLE NOVALIDATE
);

drop table if exists `insurance_fnol`.`Claims`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Claims` (
    `Claim_ID` INT NOT NULL,
    `FNOL_ID` INT NOT NULL,
    `Effective_Date` DATE,
    PRIMARY KEY (`Claim_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`FNOL_ID`) REFERENCES `insurance_fnol`.`First_Notification_of_Loss` (`FNOL_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Claim_ID`) DISABLE NOVALIDATE
);

drop table if exists `insurance_fnol`.`Settlements`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Settlements` (
    `Settlement_ID` INT NOT NULL,
    `Claim_ID` INT,
    `Effective_Date` DATE,
    `Settlement_Amount` DOUBLE,
    PRIMARY KEY (`Settlement_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Claim_ID`) REFERENCES `insurance_fnol`.`Claims` (`Claim_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Settlement_ID`) DISABLE NOVALIDATE
);
