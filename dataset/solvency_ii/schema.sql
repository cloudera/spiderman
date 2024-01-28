CREATE DATABASE IF NOT EXISTS `solvency_ii`;

drop table if exists `solvency_ii`.`Addresses`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Addresses` (
    `Address_ID` INT NOT NULL,
    `address_details` STRING,
    PRIMARY KEY (`Address_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Address_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Locations`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Locations` (
    `Location_ID` INT NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Location_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Products`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Products` (
    `Product_ID` INT NOT NULL,
    `Product_Type_Code` CHAR(15),
    `Product_Name` STRING,
    `Product_Price` DECIMAL(20,4),
    PRIMARY KEY (`Product_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Product_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Parties`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Parties` (
    `Party_ID` INT NOT NULL,
    `Party_Details` STRING,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Assets`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Assets` (
    `Asset_ID` INT NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Asset_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Channels`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Channels` (
    `Channel_ID` INT NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Channel_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Finances`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Finances` (
    `Finance_ID` INT NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Finance_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Events`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Events` (
    `Event_ID` INT NOT NULL,
    `Address_ID` INT,
    `Channel_ID` INT NOT NULL,
    `Event_Type_Code` CHAR(15),
    `Finance_ID` INT NOT NULL,
    `Location_ID` INT NOT NULL,
    PRIMARY KEY (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Finance_ID`) REFERENCES `solvency_ii`.`Finances` (`Finance_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Address_ID`) REFERENCES `solvency_ii`.`Addresses` (`Address_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Location_ID`) REFERENCES `solvency_ii`.`Locations` (`Location_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Event_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Products_in_Events`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Products_in_Events` (
    `Product_in_Event_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    `Product_ID` INT NOT NULL,
    PRIMARY KEY (`Product_in_Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Product_ID`) REFERENCES `solvency_ii`.`Products` (`Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Parties_in_Events`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Parties_in_Events` (
    `Party_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    `Role_Code` CHAR(15),
    PRIMARY KEY (`Party_ID`, `Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party_ID`) REFERENCES `solvency_ii`.`Parties` (`Party_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Agreements`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Agreements` (
    `Document_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE
);

drop table if exists `solvency_ii`.`Assets_in_Events`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Assets_in_Events` (
    `Asset_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    PRIMARY KEY (`Asset_ID`, `Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE
);
