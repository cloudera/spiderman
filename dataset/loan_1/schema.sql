CREATE DATABASE IF NOT EXISTS `loan_1`;

drop table if exists `loan_1`.`bank`;
CREATE TABLE IF NOT EXISTS `loan_1`.`bank` (
    `branch_ID` INT,
    `bname` STRING,
    `no_of_customers` INT,
    `city` STRING,
    `state` STRING,
    PRIMARY KEY (`branch_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/loan_1/data/bank.csv' INTO TABLE `loan_1`.`bank`;


drop table if exists `loan_1`.`customer`;
CREATE TABLE IF NOT EXISTS `loan_1`.`customer` (
    `cust_ID` INT,
    `cust_name` STRING,
    `acc_type` CHAR(1),
    `acc_bal` INT,
    `no_of_loans` INT,
    `credit_score` INT,
    `branch_ID` INT,
    `state` STRING,
    PRIMARY KEY (`cust_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`branch_ID`) REFERENCES `loan_1`.`bank` (`branch_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/loan_1/data/customer.csv' INTO TABLE `loan_1`.`customer`;


drop table if exists `loan_1`.`loan`;
CREATE TABLE IF NOT EXISTS `loan_1`.`loan` (
    `loan_ID` INT,
    `loan_type` STRING,
    `cust_ID` INT,
    `branch_ID` INT,
    `amount` INT,
    PRIMARY KEY (`loan_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cust_ID`) REFERENCES `loan_1`.`customer` (`Cust_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`branch_ID`) REFERENCES `loan_1`.`bank` (`branch_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/loan_1/data/loan.csv' INTO TABLE `loan_1`.`loan`;

