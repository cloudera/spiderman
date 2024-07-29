-- Dialect: MySQL | Database: cre_Docs_and_Epenses | Table Count: 7

CREATE DATABASE IF NOT EXISTS `cre_Docs_and_Epenses`;

DROP TABLE IF EXISTS `cre_Docs_and_Epenses`.`Ref_Document_Types`;
CREATE TABLE `cre_Docs_and_Epenses`.`Ref_Document_Types` (
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Type_Name` VARCHAR(255) NOT NULL,
    `Document_Type_Description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Document_Type_Code`)
);

DROP TABLE IF EXISTS `cre_Docs_and_Epenses`.`Ref_Budget_Codes`;
CREATE TABLE `cre_Docs_and_Epenses`.`Ref_Budget_Codes` (
    `Budget_Type_Code` CHAR(15) NOT NULL,
    `Budget_Type_Description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Budget_Type_Code`)
);

DROP TABLE IF EXISTS `cre_Docs_and_Epenses`.`Projects`;
CREATE TABLE `cre_Docs_and_Epenses`.`Projects` (
    `Project_ID` INTEGER NOT NULL,
    `Project_Details` VARCHAR(255),
    PRIMARY KEY (`Project_ID`)
);

DROP TABLE IF EXISTS `cre_Docs_and_Epenses`.`Documents`;
CREATE TABLE `cre_Docs_and_Epenses`.`Documents` (
    `Document_ID` INTEGER NOT NULL,
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Project_ID` INTEGER NOT NULL,
    `Document_Date` DATETIME,
    `Document_Name` VARCHAR(255),
    `Document_Description` VARCHAR(255),
    `Other_Details` VARCHAR(255),
    PRIMARY KEY (`Document_ID`),
    FOREIGN KEY (`Project_ID`) REFERENCES `cre_Docs_and_Epenses`.`Projects` (`Project_ID`),
    FOREIGN KEY (`Document_Type_Code`) REFERENCES `cre_Docs_and_Epenses`.`Ref_Document_Types` (`Document_Type_Code`)
);

DROP TABLE IF EXISTS `cre_Docs_and_Epenses`.`Statements`;
CREATE TABLE `cre_Docs_and_Epenses`.`Statements` (
    `Statement_ID` INTEGER NOT NULL,
    `Statement_Details` VARCHAR(255),
    PRIMARY KEY (`Statement_ID`),
    FOREIGN KEY (`Statement_ID`) REFERENCES `cre_Docs_and_Epenses`.`Documents` (`Document_ID`)
);

DROP TABLE IF EXISTS `cre_Docs_and_Epenses`.`Documents_with_Expenses`;
CREATE TABLE `cre_Docs_and_Epenses`.`Documents_with_Expenses` (
    `Document_ID` INTEGER NOT NULL,
    `Budget_Type_Code` CHAR(15) NOT NULL,
    `Document_Details` VARCHAR(255),
    PRIMARY KEY (`Document_ID`),
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Docs_and_Epenses`.`Documents` (`Document_ID`),
    FOREIGN KEY (`Budget_Type_Code`) REFERENCES `cre_Docs_and_Epenses`.`Ref_Budget_Codes` (`Budget_Type_Code`)
);

DROP TABLE IF EXISTS `cre_Docs_and_Epenses`.`Accounts`;
CREATE TABLE `cre_Docs_and_Epenses`.`Accounts` (
    `Account_ID` INTEGER NOT NULL,
    `Statement_ID` INTEGER NOT NULL,
    `Account_Details` VARCHAR(255),
    PRIMARY KEY (`Account_ID`),
    FOREIGN KEY (`Statement_ID`) REFERENCES `cre_Docs_and_Epenses`.`Statements` (`Statement_ID`)
);
