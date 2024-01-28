CREATE DATABASE IF NOT EXISTS `company_1`;

drop table if exists `company_1`.`works_on`;
CREATE TABLE IF NOT EXISTS `company_1`.`works_on` (
    `Essn` INT,
    `Pno` INT,
    `Hours` DOUBLE,
    PRIMARY KEY (`Essn`, `Pno`) DISABLE NOVALIDATE
);

drop table if exists `company_1`.`employee`;
CREATE TABLE IF NOT EXISTS `company_1`.`employee` (
    `Fname` STRING,
    `Minit` STRING,
    `Lname` STRING,
    `Ssn` INT,
    `Bdate` STRING,
    `Address` STRING,
    `Sex` STRING,
    `Salary` INT,
    `Super_ssn` INT,
    `Dno` INT,
    PRIMARY KEY (`Ssn`) DISABLE NOVALIDATE
);

drop table if exists `company_1`.`department`;
CREATE TABLE IF NOT EXISTS `company_1`.`department` (
    `Dname` STRING,
    `Dnumber` INT,
    `Mgr_ssn` INT,
    `Mgr_start_date` STRING,
    PRIMARY KEY (`Dnumber`) DISABLE NOVALIDATE
);

drop table if exists `company_1`.`project`;
CREATE TABLE IF NOT EXISTS `company_1`.`project` (
    `Pname` STRING,
    `Pnumber` INT,
    `Plocation` STRING,
    `Dnum` INT,
    PRIMARY KEY (`Pnumber`) DISABLE NOVALIDATE
);

drop table if exists `company_1`.`dependent`;
CREATE TABLE IF NOT EXISTS `company_1`.`dependent` (
    `Essn` INT,
    `Dependent_name` STRING,
    `Sex` STRING,
    `Bdate` STRING,
    `Relationship` STRING,
    PRIMARY KEY (`Essn`, `Dependent_name`) DISABLE NOVALIDATE
);

drop table if exists `company_1`.`dept_locations`;
CREATE TABLE IF NOT EXISTS `company_1`.`dept_locations` (
    `Dnumber` INT,
    `Dlocation` STRING,
    PRIMARY KEY (`Dnumber`, `Dlocation`) DISABLE NOVALIDATE
);
