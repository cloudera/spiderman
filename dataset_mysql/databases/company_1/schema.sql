-- Dialect: mysql | Database: company_1 | Table Count: 6

CREATE TABLE `company_1`.`works_on` (
    `Essn` INTEGER,
    `Pno` INTEGER,
    `Hours` REAL,
    PRIMARY KEY (`Essn`, `Pno`)
);

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

CREATE TABLE `company_1`.`department` (
    `Dname` TEXT,
    `Dnumber` INTEGER,
    `Mgr_ssn` INTEGER,
    `Mgr_start_date` TEXT,
    PRIMARY KEY (`Dnumber`)
);

CREATE TABLE `company_1`.`project` (
    `Pname` TEXT,
    `Pnumber` INTEGER,
    `Plocation` TEXT,
    `Dnum` INTEGER,
    PRIMARY KEY (`Pnumber`)
);

CREATE TABLE `company_1`.`dependent` (
    `Essn` INTEGER,
    `Dependent_name` VARCHAR(50),
    `Sex` TEXT,
    `Bdate` TEXT,
    `Relationship` TEXT,
    PRIMARY KEY (`Essn`, `Dependent_name`)
);

CREATE TABLE `company_1`.`dept_locations` (
    `Dnumber` INTEGER,
    `Dlocation` VARCHAR(50),
    PRIMARY KEY (`Dnumber`, `Dlocation`)
);
