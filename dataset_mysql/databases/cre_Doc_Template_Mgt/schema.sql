-- Dialect: MySQL | Database: cre_Doc_Template_Mgt | Table Count: 4

CREATE DATABASE IF NOT EXISTS `cre_Doc_Template_Mgt`;

DROP TABLE IF EXISTS `cre_Doc_Template_Mgt`.`Ref_Template_Types`;
CREATE TABLE `cre_Doc_Template_Mgt`.`Ref_Template_Types` (
    `Template_Type_Code` CHAR(15) NOT NULL,
    `Template_Type_Description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Template_Type_Code`)
);

DROP TABLE IF EXISTS `cre_Doc_Template_Mgt`.`Templates`;
CREATE TABLE `cre_Doc_Template_Mgt`.`Templates` (
    `Template_ID` INTEGER NOT NULL,
    `Version_Number` INTEGER NOT NULL,
    `Template_Type_Code` CHAR(15) NOT NULL,
    `Date_Effective_From` DATETIME,
    `Date_Effective_To` DATETIME,
    `Template_Details` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Template_ID`),
    FOREIGN KEY (`Template_Type_Code`) REFERENCES `cre_Doc_Template_Mgt`.`Ref_Template_Types` (`Template_Type_Code`)
);

DROP TABLE IF EXISTS `cre_Doc_Template_Mgt`.`Documents`;
CREATE TABLE `cre_Doc_Template_Mgt`.`Documents` (
    `Document_ID` INTEGER NOT NULL,
    `Template_ID` INTEGER,
    `Document_Name` VARCHAR(255),
    `Document_Description` VARCHAR(255),
    `Other_Details` VARCHAR(255),
    PRIMARY KEY (`Document_ID`),
    FOREIGN KEY (`Template_ID`) REFERENCES `cre_Doc_Template_Mgt`.`Templates` (`Template_ID`)
);

DROP TABLE IF EXISTS `cre_Doc_Template_Mgt`.`Paragraphs`;
CREATE TABLE `cre_Doc_Template_Mgt`.`Paragraphs` (
    `Paragraph_ID` INTEGER NOT NULL,
    `Document_ID` INTEGER NOT NULL,
    `Paragraph_Text` VARCHAR(255),
    `Other_Details` VARCHAR(255),
    PRIMARY KEY (`Paragraph_ID`),
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Template_Mgt`.`Documents` (`Document_ID`)
);
