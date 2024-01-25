drop table if exists `hr_1`.`regions`;
CREATE TABLE IF NOT EXISTS `hr_1`.`regions` (
    `REGION_ID` INT NOT NULL,
    `REGION_NAME` STRING,
    PRIMARY KEY (`REGION_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/regions.csv' INTO TABLE `hr_1`.`regions`;


drop table if exists `hr_1`.`countries`;
CREATE TABLE IF NOT EXISTS `hr_1`.`countries` (
    `COUNTRY_ID` STRING NOT NULL,
    `COUNTRY_NAME` STRING,
    `REGION_ID` INT,
    PRIMARY KEY (`COUNTRY_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`REGION_ID`) REFERENCES `hr_1`.`regions` (`REGION_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/countries.csv' INTO TABLE `hr_1`.`countries`;


drop table if exists `hr_1`.`departments`;
CREATE TABLE IF NOT EXISTS `hr_1`.`departments` (
    `DEPARTMENT_ID` DECIMAL(4,0) NOT NULL,
    `DEPARTMENT_NAME` STRING NOT NULL,
    `MANAGER_ID` DECIMAL(6,0),
    `LOCATION_ID` DECIMAL(4,0),
    PRIMARY KEY (`DEPARTMENT_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/departments.csv' INTO TABLE `hr_1`.`departments`;


drop table if exists `hr_1`.`jobs`;
CREATE TABLE IF NOT EXISTS `hr_1`.`jobs` (
    `JOB_ID` STRING NOT NULL,
    `JOB_TITLE` STRING NOT NULL,
    `MIN_SALARY` DECIMAL(6,0),
    `MAX_SALARY` DECIMAL(6,0),
    PRIMARY KEY (`JOB_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/jobs.csv' INTO TABLE `hr_1`.`jobs`;


drop table if exists `hr_1`.`employees`;
CREATE TABLE IF NOT EXISTS `hr_1`.`employees` (
    `EMPLOYEE_ID` DECIMAL(6,0) NOT NULL,
    `FIRST_NAME` STRING,
    `LAST_NAME` STRING NOT NULL,
    `EMAIL` STRING NOT NULL,
    `PHONE_NUMBER` STRING,
    `HIRE_DATE` DATE NOT NULL,
    `JOB_ID` STRING NOT NULL,
    `SALARY` DECIMAL(8,2),
    `COMMISSION_PCT` DECIMAL(2,2),
    `MANAGER_ID` DECIMAL(6,0),
    `DEPARTMENT_ID` DECIMAL(4,0),
    PRIMARY KEY (`EMPLOYEE_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`JOB_ID`) REFERENCES `hr_1`.`jobs` (`JOB_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `hr_1`.`departments` (`DEPARTMENT_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/employees.csv' INTO TABLE `hr_1`.`employees`;


drop table if exists `hr_1`.`job_history`;
CREATE TABLE IF NOT EXISTS `hr_1`.`job_history` (
    `EMPLOYEE_ID` DECIMAL(6,0) NOT NULL,
    `START_DATE` DATE NOT NULL,
    `END_DATE` DATE NOT NULL,
    `JOB_ID` STRING NOT NULL,
    `DEPARTMENT_ID` DECIMAL(4,0),
    PRIMARY KEY (`EMPLOYEE_ID`, `START_DATE`) DISABLE NOVALIDATE,
    FOREIGN KEY (`JOB_ID`) REFERENCES `hr_1`.`jobs` (`JOB_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `hr_1`.`departments` (`DEPARTMENT_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`EMPLOYEE_ID`) REFERENCES `hr_1`.`employees` (`EMPLOYEE_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/job_history.csv' INTO TABLE `hr_1`.`job_history`;


drop table if exists `hr_1`.`locations`;
CREATE TABLE IF NOT EXISTS `hr_1`.`locations` (
    `LOCATION_ID` DECIMAL(4,0) NOT NULL,
    `STREET_ADDRESS` STRING,
    `POSTAL_CODE` STRING,
    `CITY` STRING NOT NULL,
    `STATE_PROVINCE` STRING,
    `COUNTRY_ID` STRING,
    PRIMARY KEY (`LOCATION_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`COUNTRY_ID`) REFERENCES `hr_1`.`countries` (`COUNTRY_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/locations.csv' INTO TABLE `hr_1`.`locations`;

