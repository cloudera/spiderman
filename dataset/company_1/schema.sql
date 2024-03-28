-- Dialect: MySQL | Database: company_1 | Table Count: 6

CREATE DATABASE IF NOT EXISTS `company_1`;

DROP TABLE IF EXISTS `company_1`.`works_on`;
CREATE TABLE `company_1`.`works_on` (
    `Essn` INTEGER,
    `Pno` INTEGER,
    `Hours` REAL,
    PRIMARY KEY (`Essn`, `Pno`)
);

DROP TABLE IF EXISTS `company_1`.`employee`;
CREATE TABLE `company_1`.`employee` (
    `Fname` TEXT,
    `Minit` TEXT,
    `Lname` TEXT,
    `Ssn` INTEGER,
    `Bdate` TEXT,
    `Address` TEXT,
    `Sex` TEXT,
    `Salary` INTEGER,
    `Super_ssn` INTEGER,
    `Dno` INTEGER,
    PRIMARY KEY (`Ssn`)
);

DROP TABLE IF EXISTS `company_1`.`department`;
CREATE TABLE `company_1`.`department` (
    `Dname` TEXT,
    `Dnumber` INTEGER,
    `Mgr_ssn` INTEGER,
    `Mgr_start_date` TEXT,
    PRIMARY KEY (`Dnumber`)
);

DROP TABLE IF EXISTS `company_1`.`project`;
CREATE TABLE `company_1`.`project` (
    `Pname` TEXT,
    `Pnumber` INTEGER,
    `Plocation` TEXT,
    `Dnum` INTEGER,
    PRIMARY KEY (`Pnumber`)
);

DROP TABLE IF EXISTS `company_1`.`dependent`;
CREATE TABLE `company_1`.`dependent` (
    `Essn` INTEGER,
    `Dependent_name` VARCHAR(50),
    `Sex` TEXT,
    `Bdate` TEXT,
    `Relationship` TEXT,
    PRIMARY KEY (`Essn`, `Dependent_name`)
);

DROP TABLE IF EXISTS `company_1`.`dept_locations`;
CREATE TABLE `company_1`.`dept_locations` (
    `Dnumber` INTEGER,
    `Dlocation` VARCHAR(50),
    PRIMARY KEY (`Dnumber`, `Dlocation`)
);
