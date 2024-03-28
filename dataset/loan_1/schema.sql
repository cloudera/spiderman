-- Dialect: MySQL | Database: loan_1 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `loan_1`;

DROP TABLE IF EXISTS `loan_1`.`bank`;
CREATE TABLE `loan_1`.`bank` (
    `branch_ID` INT,
    `bname` VARCHAR(20),
    `no_of_customers` INT,
    `city` VARCHAR(10),
    `state` VARCHAR(20),
    PRIMARY KEY (`branch_ID`)
);

DROP TABLE IF EXISTS `loan_1`.`customer`;
CREATE TABLE `loan_1`.`customer` (
    `cust_ID` INT,
    `cust_name` VARCHAR(20),
    `acc_type` CHAR(1),
    `acc_bal` INT,
    `no_of_loans` INT,
    `credit_score` INT,
    `branch_ID` INT,
    `state` VARCHAR(20),
    PRIMARY KEY (`cust_ID`),
    FOREIGN KEY (`branch_ID`) REFERENCES `loan_1`.`bank` (`branch_ID`)
);

DROP TABLE IF EXISTS `loan_1`.`loan`;
CREATE TABLE `loan_1`.`loan` (
    `loan_ID` INT,
    `loan_type` VARCHAR(15),
    `cust_ID` INT,
    `branch_ID` INT,
    `amount` INT,
    PRIMARY KEY (`loan_ID`),
    FOREIGN KEY (`cust_ID`) REFERENCES `loan_1`.`customer` (`Cust_ID`),
    FOREIGN KEY (`branch_ID`) REFERENCES `loan_1`.`bank` (`branch_ID`)
);
