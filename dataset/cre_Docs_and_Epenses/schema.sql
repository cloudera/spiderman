CREATE DATABASE IF NOT EXISTS `cre_Docs_and_Epenses`;

drop table if exists `cre_Docs_and_Epenses`.`Ref_Document_Types`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Ref_Document_Types` (
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Type_Name` STRING NOT NULL,
    `Document_Type_Description` STRING NOT NULL,
    PRIMARY KEY (`Document_Type_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Docs_and_Epenses`.`Ref_Budget_Codes`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Ref_Budget_Codes` (
    `Budget_Type_Code` CHAR(15) NOT NULL,
    `Budget_Type_Description` STRING NOT NULL,
    PRIMARY KEY (`Budget_Type_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Docs_and_Epenses`.`Projects`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Projects` (
    `Project_ID` INT NOT NULL,
    `Project_Details` STRING,
    PRIMARY KEY (`Project_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Docs_and_Epenses`.`Documents`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Documents` (
    `Document_ID` INT NOT NULL,
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Project_ID` INT NOT NULL,
    `Document_Date` TIMESTAMP,
    `Document_Name` STRING,
    `Document_Description` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Project_ID`) REFERENCES `cre_Docs_and_Epenses`.`Projects` (`Project_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_Type_Code`) REFERENCES `cre_Docs_and_Epenses`.`Ref_Document_Types` (`Document_Type_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Docs_and_Epenses`.`Statements`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Statements` (
    `Statement_ID` INT NOT NULL,
    `Statement_Details` STRING,
    PRIMARY KEY (`Statement_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Statement_ID`) REFERENCES `cre_Docs_and_Epenses`.`Documents` (`Document_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Docs_and_Epenses`.`Documents_with_Expenses`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Documents_with_Expenses` (
    `Document_ID` INT NOT NULL,
    `Budget_Type_Code` CHAR(15) NOT NULL,
    `Document_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Docs_and_Epenses`.`Documents` (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Budget_Type_Code`) REFERENCES `cre_Docs_and_Epenses`.`Ref_Budget_Codes` (`Budget_Type_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Docs_and_Epenses`.`Accounts`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Accounts` (
    `Account_ID` INT NOT NULL,
    `Statement_ID` INT NOT NULL,
    `Account_Details` STRING,
    PRIMARY KEY (`Account_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Statement_ID`) REFERENCES `cre_Docs_and_Epenses`.`Statements` (`Statement_ID`) DISABLE NOVALIDATE
);
