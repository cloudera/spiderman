-- Dialect: MySQL | Database: customer_complaints | Table Count: 4

CREATE DATABASE IF NOT EXISTS `customer_complaints`;

DROP TABLE IF EXISTS `customer_complaints`.`Staff`;
CREATE TABLE `customer_complaints`.`Staff` (
    `staff_id` INTEGER,
    `gender` VARCHAR(1),
    `first_name` VARCHAR(80),
    `last_name` VARCHAR(80),
    `email_address` VARCHAR(255),
    `phone_number` VARCHAR(80),
    PRIMARY KEY (`staff_id`)
);

DROP TABLE IF EXISTS `customer_complaints`.`Customers`;
CREATE TABLE `customer_complaints`.`Customers` (
    `customer_id` INTEGER,
    `customer_type_code` VARCHAR(20) NOT NULL,
    `address_line_1` VARCHAR(80),
    `address_line_2` VARCHAR(80),
    `town_city` VARCHAR(80),
    `state` VARCHAR(80),
    `email_address` VARCHAR(255),
    `phone_number` VARCHAR(80),
    PRIMARY KEY (`customer_id`)
);

DROP TABLE IF EXISTS `customer_complaints`.`Products`;
CREATE TABLE `customer_complaints`.`Products` (
    `product_id` INTEGER,
    `parent_product_id` INTEGER,
    `product_category_code` VARCHAR(20) NOT NULL,
    `date_product_first_available` DATETIME,
    `date_product_discontinued` DATETIME,
    `product_name` VARCHAR(80),
    `product_description` VARCHAR(255),
    `product_price` DECIMAL(19,4),
    PRIMARY KEY (`product_id`)
);

DROP TABLE IF EXISTS `customer_complaints`.`Complaints`;
CREATE TABLE `customer_complaints`.`Complaints` (
    `complaint_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `complaint_outcome_code` VARCHAR(20) NOT NULL,
    `complaint_status_code` VARCHAR(20) NOT NULL,
    `complaint_type_code` VARCHAR(20) NOT NULL,
    `date_complaint_raised` DATETIME,
    `date_complaint_closed` DATETIME,
    `staff_id` INTEGER NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customer_complaints`.`Customers` (`customer_id`),
    FOREIGN KEY (`product_id`) REFERENCES `customer_complaints`.`Products` (`product_id`),
    FOREIGN KEY (`staff_id`) REFERENCES `customer_complaints`.`Staff` (`staff_id`)
);
