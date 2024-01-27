CREATE DATABASE IF NOT EXISTS `company_employee`;

drop table if exists `company_employee`.`people`;
CREATE TABLE IF NOT EXISTS `company_employee`.`people` (
    `People_ID` INT,
    `Age` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Graduation_College` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_employee/data/people.csv' INTO TABLE `company_employee`.`people`;


drop table if exists `company_employee`.`company`;
CREATE TABLE IF NOT EXISTS `company_employee`.`company` (
    `Company_ID` INT,
    `Name` STRING,
    `Headquarters` STRING,
    `Industry` STRING,
    `Sales_in_Billion` REAL,
    `Profits_in_Billion` REAL,
    `Assets_in_Billion` REAL,
    `Market_Value_in_Billion` REAL,
    PRIMARY KEY (`Company_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_employee/data/company.csv' INTO TABLE `company_employee`.`company`;


drop table if exists `company_employee`.`employment`;
CREATE TABLE IF NOT EXISTS `company_employee`.`employment` (
    `Company_ID` INT,
    `People_ID` INT,
    `Year_working` INT,
    PRIMARY KEY (`Company_ID`, `People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `company_employee`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Company_ID`) REFERENCES `company_employee`.`company` (`Company_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_employee/data/employment.csv' INTO TABLE `company_employee`.`employment`;

