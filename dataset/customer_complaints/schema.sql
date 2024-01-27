CREATE DATABASE IF NOT EXISTS `customer_complaints`;

drop table if exists `customer_complaints`.`Staff`;
CREATE TABLE IF NOT EXISTS `customer_complaints`.`Staff` (
    `staff_id` INT,
    `gender` STRING,
    `first_name` STRING,
    `last_name` STRING,
    `email_address` STRING,
    `phone_number` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_complaints/data/Staff.csv' INTO TABLE `customer_complaints`.`Staff`;


drop table if exists `customer_complaints`.`Customers`;
CREATE TABLE IF NOT EXISTS `customer_complaints`.`Customers` (
    `customer_id` INT,
    `customer_type_code` STRING NOT NULL,
    `address_line_1` STRING,
    `address_line_2` STRING,
    `town_city` STRING,
    `state` STRING,
    `email_address` STRING,
    `phone_number` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_complaints/data/Customers.csv' INTO TABLE `customer_complaints`.`Customers`;


drop table if exists `customer_complaints`.`Products`;
CREATE TABLE IF NOT EXISTS `customer_complaints`.`Products` (
    `product_id` INT,
    `parent_product_id` INT,
    `product_category_code` STRING NOT NULL,
    `date_product_first_available` TIMESTAMP,
    `date_product_discontinued` TIMESTAMP,
    `product_name` STRING,
    `product_description` STRING,
    `product_price` DECIMAL(19,4),
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_complaints/data/Products.csv' INTO TABLE `customer_complaints`.`Products`;


drop table if exists `customer_complaints`.`Complaints`;
CREATE TABLE IF NOT EXISTS `customer_complaints`.`Complaints` (
    `complaint_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `complaint_outcome_code` STRING NOT NULL,
    `complaint_status_code` STRING NOT NULL,
    `complaint_type_code` STRING NOT NULL,
    `date_complaint_raised` TIMESTAMP,
    `date_complaint_closed` TIMESTAMP,
    `staff_id` INT NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customer_complaints`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customer_complaints`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `customer_complaints`.`Staff` (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_complaints/data/Complaints.csv' INTO TABLE `customer_complaints`.`Complaints`;

