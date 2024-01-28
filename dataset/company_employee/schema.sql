CREATE DATABASE IF NOT EXISTS `company_employee`;

drop table if exists `company_employee`.`people`;
CREATE TABLE IF NOT EXISTS `company_employee`.`people` (
    `People_ID` INT,
    `Age` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Graduation_College` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
);

drop table if exists `company_employee`.`company`;
CREATE TABLE IF NOT EXISTS `company_employee`.`company` (
    `Company_ID` INT,
    `Name` STRING,
    `Headquarters` STRING,
    `Industry` STRING,
    `Sales_in_Billion` DOUBLE,
    `Profits_in_Billion` DOUBLE,
    `Assets_in_Billion` DOUBLE,
    `Market_Value_in_Billion` DOUBLE,
    PRIMARY KEY (`Company_ID`) DISABLE NOVALIDATE
);

drop table if exists `company_employee`.`employment`;
CREATE TABLE IF NOT EXISTS `company_employee`.`employment` (
    `Company_ID` INT,
    `People_ID` INT,
    `Year_working` INT,
    PRIMARY KEY (`Company_ID`, `People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `company_employee`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Company_ID`) REFERENCES `company_employee`.`company` (`Company_ID`) DISABLE NOVALIDATE
);
