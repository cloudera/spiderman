CREATE DATABASE IF NOT EXISTS `tracking_software_problems`;

drop table if exists `tracking_software_problems`.`Problem_Category_Codes`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Problem_Category_Codes` (
    `problem_category_code` STRING,
    `problem_category_description` STRING,
    PRIMARY KEY (`problem_category_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Problem_Category_Codes.csv' INTO TABLE `tracking_software_problems`.`Problem_Category_Codes`;


drop table if exists `tracking_software_problems`.`Problem_Status_Codes`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Problem_Status_Codes` (
    `problem_status_code` STRING,
    `problem_status_description` STRING,
    PRIMARY KEY (`problem_status_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Problem_Status_Codes.csv' INTO TABLE `tracking_software_problems`.`Problem_Status_Codes`;


drop table if exists `tracking_software_problems`.`Staff`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Staff` (
    `staff_id` INT,
    `staff_first_name` STRING,
    `staff_last_name` STRING,
    `other_staff_details` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Staff.csv' INTO TABLE `tracking_software_problems`.`Staff`;


drop table if exists `tracking_software_problems`.`Product`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Product` (
    `product_id` INT,
    `product_name` STRING,
    `product_details` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Product.csv' INTO TABLE `tracking_software_problems`.`Product`;


drop table if exists `tracking_software_problems`.`Problems`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Problems` (
    `problem_id` INT,
    `product_id` INT NOT NULL,
    `closure_authorised_by_staff_id` INT NOT NULL,
    `reported_by_staff_id` INT NOT NULL,
    `date_problem_reported` TIMESTAMP NOT NULL,
    `date_problem_closed` TIMESTAMP,
    `problem_description` STRING,
    `other_problem_details` STRING,
    PRIMARY KEY (`problem_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`reported_by_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `tracking_software_problems`.`Product` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`closure_authorised_by_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Problems.csv' INTO TABLE `tracking_software_problems`.`Problems`;


drop table if exists `tracking_software_problems`.`Problem_Log`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Problem_Log` (
    `problem_log_id` INT,
    `assigned_to_staff_id` INT NOT NULL,
    `problem_id` INT NOT NULL,
    `problem_category_code` STRING NOT NULL,
    `problem_status_code` STRING NOT NULL,
    `log_entry_date` TIMESTAMP,
    `log_entry_description` STRING,
    `log_entry_fix` STRING,
    `other_log_details` STRING,
    PRIMARY KEY (`problem_log_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`problem_status_code`) REFERENCES `tracking_software_problems`.`Problem_Status_Codes` (`problem_status_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`problem_id`) REFERENCES `tracking_software_problems`.`Problems` (`problem_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`assigned_to_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`problem_category_code`) REFERENCES `tracking_software_problems`.`Problem_Category_Codes` (`problem_category_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Problem_Log.csv' INTO TABLE `tracking_software_problems`.`Problem_Log`;

