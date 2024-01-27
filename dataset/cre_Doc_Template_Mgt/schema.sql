drop table if exists `cre_Doc_Template_Mgt`.`Ref_Template_Types`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Template_Mgt`.`Ref_Template_Types` (
    `Template_Type_Code` CHAR(15) NOT NULL,
    `Template_Type_Description` STRING NOT NULL,
    PRIMARY KEY (`Template_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Template_Mgt/data/Ref_Template_Types.csv' INTO TABLE `cre_Doc_Template_Mgt`.`Ref_Template_Types`;


drop table if exists `cre_Doc_Template_Mgt`.`Templates`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Template_Mgt`.`Templates` (
    `Template_ID` INT NOT NULL,
    `Version_Number` INT NOT NULL,
    `Template_Type_Code` CHAR(15) NOT NULL,
    `Date_Effective_From` TIMESTAMP,
    `Date_Effective_To` TIMESTAMP,
    `Template_Details` STRING NOT NULL,
    PRIMARY KEY (`Template_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Template_Type_Code`) REFERENCES `cre_Doc_Template_Mgt`.`Ref_Template_Types` (`Template_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Template_Mgt/data/Templates.csv' INTO TABLE `cre_Doc_Template_Mgt`.`Templates`;


drop table if exists `cre_Doc_Template_Mgt`.`Documents`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Template_Mgt`.`Documents` (
    `Document_ID` INT NOT NULL,
    `Template_ID` INT,
    `Document_Name` STRING,
    `Document_Description` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Template_ID`) REFERENCES `cre_Doc_Template_Mgt`.`Templates` (`Template_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Template_Mgt/data/Documents.csv' INTO TABLE `cre_Doc_Template_Mgt`.`Documents`;


drop table if exists `cre_Doc_Template_Mgt`.`Paragraphs`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Template_Mgt`.`Paragraphs` (
    `Paragraph_ID` INT NOT NULL,
    `Document_ID` INT NOT NULL,
    `Paragraph_Text` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Paragraph_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Template_Mgt`.`Documents` (`Document_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Template_Mgt/data/Paragraphs.csv' INTO TABLE `cre_Doc_Template_Mgt`.`Paragraphs`;
