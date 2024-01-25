drop table if exists `department_management`.`department`;
CREATE TABLE IF NOT EXISTS `department_management`.`department` (
    `Department_ID` INT,
    `Name` STRING,
    `Creation` STRING,
    `Ranking` INT,
    `Budget_in_Billions` REAL,
    `Num_Employees` REAL,
    PRIMARY KEY (`Department_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_management/data/department.csv' INTO TABLE `department_management`.`department`;


drop table if exists `department_management`.`head`;
CREATE TABLE IF NOT EXISTS `department_management`.`head` (
    `head_ID` INT,
    `name` STRING,
    `born_state` STRING,
    `age` REAL,
    PRIMARY KEY (`head_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_management/data/head.csv' INTO TABLE `department_management`.`head`;


drop table if exists `department_management`.`management`;
CREATE TABLE IF NOT EXISTS `department_management`.`management` (
    `department_ID` INT,
    `head_ID` INT,
    `temporary_acting` STRING,
    PRIMARY KEY (`department_ID`, `head_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`head_ID`) REFERENCES `department_management`.`head` (`head_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`department_ID`) REFERENCES `department_management`.`department` (`Department_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_management/data/management.csv' INTO TABLE `department_management`.`management`;

