drop table if exists `company_1`.`works_on`;
CREATE TABLE IF NOT EXISTS `company_1`.`works_on` (
    `Essn` INT,
    `Pno` INT,
    `Hours` REAL,
    PRIMARY KEY (`Essn`, `Pno`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/works_on.csv' INTO TABLE `company_1`.`works_on`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/employee.csv' INTO TABLE `company_1`.`employee`;


drop table if exists `company_1`.`department`;
CREATE TABLE IF NOT EXISTS `company_1`.`department` (
    `Dname` STRING,
    `Dnumber` INT,
    `Mgr_ssn` INT,
    `Mgr_start_date` STRING,
    PRIMARY KEY (`Dnumber`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/department.csv' INTO TABLE `company_1`.`department`;


drop table if exists `company_1`.`project`;
CREATE TABLE IF NOT EXISTS `company_1`.`project` (
    `Pname` STRING,
    `Pnumber` INT,
    `Plocation` STRING,
    `Dnum` INT,
    PRIMARY KEY (`Pnumber`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/project.csv' INTO TABLE `company_1`.`project`;


drop table if exists `company_1`.`dependent`;
CREATE TABLE IF NOT EXISTS `company_1`.`dependent` (
    `Essn` INT,
    `Dependent_name` STRING,
    `Sex` STRING,
    `Bdate` STRING,
    `Relationship` STRING,
    PRIMARY KEY (`Essn`, `Dependent_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/dependent.csv' INTO TABLE `company_1`.`dependent`;


drop table if exists `company_1`.`dept_locations`;
CREATE TABLE IF NOT EXISTS `company_1`.`dept_locations` (
    `Dnumber` INT,
    `Dlocation` STRING,
    PRIMARY KEY (`Dnumber`, `Dlocation`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/dept_locations.csv' INTO TABLE `company_1`.`dept_locations`;

