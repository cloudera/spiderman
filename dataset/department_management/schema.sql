CREATE DATABASE IF NOT EXISTS `department_management`;

drop table if exists `department_management`.`department`;
CREATE TABLE IF NOT EXISTS `department_management`.`department` (
    `Department_ID` INT,
    `Name` STRING,
    `Creation` STRING,
    `Ranking` INT,
    `Budget_in_Billions` DOUBLE,
    `Num_Employees` DOUBLE,
    PRIMARY KEY (`Department_ID`) DISABLE NOVALIDATE
);

drop table if exists `department_management`.`head`;
CREATE TABLE IF NOT EXISTS `department_management`.`head` (
    `head_ID` INT,
    `name` STRING,
    `born_state` STRING,
    `age` DOUBLE,
    PRIMARY KEY (`head_ID`) DISABLE NOVALIDATE
);

drop table if exists `department_management`.`management`;
CREATE TABLE IF NOT EXISTS `department_management`.`management` (
    `department_ID` INT,
    `head_ID` INT,
    `temporary_acting` STRING,
    PRIMARY KEY (`department_ID`, `head_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`head_ID`) REFERENCES `department_management`.`head` (`head_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`department_ID`) REFERENCES `department_management`.`department` (`Department_ID`) DISABLE NOVALIDATE
);
