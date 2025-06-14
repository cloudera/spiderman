-- Dialect: mysql | Database: cre_Doc_Tracking_DB | Table Count: 8

CREATE TABLE `cre_Doc_Tracking_DB`.`Ref_Document_Types` (
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Type_Name` VARCHAR(255) NOT NULL,
    `Document_Type_Description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Document_Type_Code`)
);

CREATE TABLE `cre_Doc_Tracking_DB`.`Ref_Calendar` (
    `Calendar_Date` DATETIME NOT NULL,
    `Day_Number` INTEGER,
    PRIMARY KEY (`Calendar_Date`)
);

CREATE TABLE `cre_Doc_Tracking_DB`.`Ref_Locations` (
    `Location_Code` CHAR(15) NOT NULL,
    `Location_Name` VARCHAR(255) NOT NULL,
    `Location_Description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Location_Code`)
);

CREATE TABLE `cre_Doc_Tracking_DB`.`Roles` (
    `Role_Code` CHAR(15) NOT NULL,
    `Role_Name` VARCHAR(255),
    `Role_Description` VARCHAR(255),
    PRIMARY KEY (`Role_Code`)
);

CREATE TABLE `cre_Doc_Tracking_DB`.`All_Documents` (
    `Document_ID` INTEGER NOT NULL,
    `Date_Stored` DATETIME,
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Name` CHAR(255),
    `Document_Description` CHAR(255),
    `Other_Details` VARCHAR(255),
    PRIMARY KEY (`Document_ID`),
    FOREIGN KEY (`Date_Stored`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`),
    FOREIGN KEY (`Document_Type_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Document_Types` (`Document_Type_Code`)
);

CREATE TABLE `cre_Doc_Tracking_DB`.`Employees` (
    `Employee_ID` INTEGER NOT NULL,
    `Role_Code` CHAR(15) NOT NULL,
    `Employee_Name` VARCHAR(255),
    `Gender_MFU` CHAR(1) NOT NULL,
    `Date_of_Birth` DATETIME NOT NULL,
    `Other_Details` VARCHAR(255),
    PRIMARY KEY (`Employee_ID`),
    FOREIGN KEY (`Role_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Roles` (`Role_Code`)
);

CREATE TABLE `cre_Doc_Tracking_DB`.`Document_Locations` (
    `Document_ID` INTEGER NOT NULL,
    `Location_Code` CHAR(15) NOT NULL,
    `Date_in_Location_From` DATETIME NOT NULL,
    `Date_in_Locaton_To` DATETIME,
    PRIMARY KEY (`Document_ID`, `Location_Code`, `Date_in_Location_From`),
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Tracking_DB`.`All_Documents` (`Document_ID`),
    FOREIGN KEY (`Date_in_Locaton_To`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`),
    FOREIGN KEY (`Date_in_Location_From`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`),
    FOREIGN KEY (`Location_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Locations` (`Location_Code`)
);

CREATE TABLE `cre_Doc_Tracking_DB`.`Documents_to_be_Destroyed` (
    `Document_ID` INTEGER NOT NULL,
    `Destruction_Authorised_by_Employee_ID` INTEGER,
    `Destroyed_by_Employee_ID` INTEGER,
    `Planned_Destruction_Date` DATETIME,
    `Actual_Destruction_Date` DATETIME,
    `Other_Details` VARCHAR(255),
    PRIMARY KEY (`Document_ID`),
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Tracking_DB`.`All_Documents` (`Document_ID`),
    FOREIGN KEY (`Actual_Destruction_Date`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`),
    FOREIGN KEY (`Planned_Destruction_Date`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`),
    FOREIGN KEY (`Destruction_Authorised_by_Employee_ID`) REFERENCES `cre_Doc_Tracking_DB`.`Employees` (`Employee_ID`),
    FOREIGN KEY (`Destroyed_by_Employee_ID`) REFERENCES `cre_Doc_Tracking_DB`.`Employees` (`Employee_ID`)
);
