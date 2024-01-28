CREATE DATABASE IF NOT EXISTS `cre_Doc_Tracking_DB`;

drop table if exists `cre_Doc_Tracking_DB`.`Ref_Document_Types`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Ref_Document_Types` (
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Type_Name` STRING NOT NULL,
    `Document_Type_Description` STRING NOT NULL,
    PRIMARY KEY (`Document_Type_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Doc_Tracking_DB`.`Ref_Calendar`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Ref_Calendar` (
    `Calendar_Date` TIMESTAMP NOT NULL,
    `Day_Number` INT,
    PRIMARY KEY (`Calendar_Date`) DISABLE NOVALIDATE
);

drop table if exists `cre_Doc_Tracking_DB`.`Ref_Locations`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Ref_Locations` (
    `Location_Code` CHAR(15) NOT NULL,
    `Location_Name` STRING NOT NULL,
    `Location_Description` STRING NOT NULL,
    PRIMARY KEY (`Location_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Doc_Tracking_DB`.`Roles`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Roles` (
    `Role_Code` CHAR(15) NOT NULL,
    `Role_Name` STRING,
    `Role_Description` STRING,
    PRIMARY KEY (`Role_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Doc_Tracking_DB`.`All_Documents`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`All_Documents` (
    `Document_ID` INT NOT NULL,
    `Date_Stored` TIMESTAMP,
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Name` CHAR(255),
    `Document_Description` CHAR(255),
    `Other_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Date_Stored`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_Type_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Document_Types` (`Document_Type_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Doc_Tracking_DB`.`Employees`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Employees` (
    `Employee_ID` INT NOT NULL,
    `Role_Code` CHAR(15) NOT NULL,
    `Employee_Name` STRING,
    `Gender_MFU` CHAR(1) NOT NULL,
    `Date_of_Birth` TIMESTAMP NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Employee_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Role_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Roles` (`Role_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Doc_Tracking_DB`.`Document_Locations`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Document_Locations` (
    `Document_ID` INT NOT NULL,
    `Location_Code` CHAR(15) NOT NULL,
    `Date_in_Location_From` TIMESTAMP NOT NULL,
    `Date_in_Locaton_To` TIMESTAMP,
    PRIMARY KEY (`Document_ID`, `Location_Code`, `Date_in_Location_From`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Tracking_DB`.`All_Documents` (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Date_in_Locaton_To`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Date_in_Location_From`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Location_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Locations` (`Location_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Doc_Tracking_DB`.`Documents_to_be_Destroyed`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Documents_to_be_Destroyed` (
    `Document_ID` INT NOT NULL,
    `Destruction_Authorised_by_Employee_ID` INT,
    `Destroyed_by_Employee_ID` INT,
    `Planned_Destruction_Date` TIMESTAMP,
    `Actual_Destruction_Date` TIMESTAMP,
    `Other_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Tracking_DB`.`All_Documents` (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Actual_Destruction_Date`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Planned_Destruction_Date`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Destruction_Authorised_by_Employee_ID`) REFERENCES `cre_Doc_Tracking_DB`.`Employees` (`Employee_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Destroyed_by_Employee_ID`) REFERENCES `cre_Doc_Tracking_DB`.`Employees` (`Employee_ID`) DISABLE NOVALIDATE
);
