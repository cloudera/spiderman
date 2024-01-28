CREATE DATABASE IF NOT EXISTS `employee_hire_evaluation`;

drop table if exists `employee_hire_evaluation`.`employee`;
CREATE TABLE IF NOT EXISTS `employee_hire_evaluation`.`employee` (
    `Employee_ID` INT,
    `Name` STRING,
    `Age` INT,
    `City` STRING,
    PRIMARY KEY (`Employee_ID`) DISABLE NOVALIDATE
);

drop table if exists `employee_hire_evaluation`.`shop`;
CREATE TABLE IF NOT EXISTS `employee_hire_evaluation`.`shop` (
    `Shop_ID` INT,
    `Name` STRING,
    `Location` STRING,
    `District` STRING,
    `Number_products` INT,
    `Manager_name` STRING,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE
);

drop table if exists `employee_hire_evaluation`.`hiring`;
CREATE TABLE IF NOT EXISTS `employee_hire_evaluation`.`hiring` (
    `Shop_ID` INT,
    `Employee_ID` INT,
    `Start_from` STRING,
    `Is_full_time` BOOLEAN,
    PRIMARY KEY (`Employee_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Employee_ID`) REFERENCES `employee_hire_evaluation`.`employee` (`Employee_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `employee_hire_evaluation`.`shop` (`Shop_ID`) DISABLE NOVALIDATE
);

drop table if exists `employee_hire_evaluation`.`evaluation`;
CREATE TABLE IF NOT EXISTS `employee_hire_evaluation`.`evaluation` (
    `Employee_ID` INT,
    `Year_awarded` STRING,
    `Bonus` DOUBLE,
    PRIMARY KEY (`Employee_ID`, `Year_awarded`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Employee_ID`) REFERENCES `employee_hire_evaluation`.`employee` (`Employee_ID`) DISABLE NOVALIDATE
);
