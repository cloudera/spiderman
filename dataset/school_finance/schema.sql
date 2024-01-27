CREATE DATABASE IF NOT EXISTS `school_finance`;

drop table if exists `school_finance`.`School`;
CREATE TABLE IF NOT EXISTS `school_finance`.`School` (
    `School_id` INT,
    `School_name` STRING,
    `Location` STRING,
    `Mascot` STRING,
    `Enrollment` INT,
    `IHSAA_Class` STRING,
    `IHSAA_Football_Class` STRING,
    `County` STRING,
    PRIMARY KEY (`School_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_finance/data/School.csv' INTO TABLE `school_finance`.`School`;


drop table if exists `school_finance`.`budget`;
CREATE TABLE IF NOT EXISTS `school_finance`.`budget` (
    `School_id` INT,
    `Year` INT,
    `Budgeted` INT,
    `total_budget_percent_budgeted` REAL,
    `Invested` INT,
    `total_budget_percent_invested` REAL,
    `Budget_invested_percent` STRING,
    PRIMARY KEY (`School_id`, `Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_id`) REFERENCES `school_finance`.`School` (`School_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_finance/data/budget.csv' INTO TABLE `school_finance`.`budget`;


drop table if exists `school_finance`.`endowment`;
CREATE TABLE IF NOT EXISTS `school_finance`.`endowment` (
    `endowment_id` INT,
    `School_id` INT,
    `donator_name` STRING,
    `amount` REAL,
    PRIMARY KEY (`endowment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_id`) REFERENCES `school_finance`.`School` (`School_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_finance/data/endowment.csv' INTO TABLE `school_finance`.`endowment`;

