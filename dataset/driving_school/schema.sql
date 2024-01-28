CREATE DATABASE IF NOT EXISTS `driving_school`;

drop table if exists `driving_school`.`Addresses`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Addresses` (
    `address_id` INT,
    `line_1_number_building` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `driving_school`.`Staff`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Staff` (
    `staff_id` INT,
    `staff_address_id` INT NOT NULL,
    `nickname` STRING,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `date_of_birth` TIMESTAMP,
    `date_joined_staff` TIMESTAMP,
    `date_left_staff` TIMESTAMP,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_address_id`) REFERENCES `driving_school`.`Addresses` (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `driving_school`.`Vehicles`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Vehicles` (
    `vehicle_id` INT,
    `vehicle_details` STRING,
    PRIMARY KEY (`vehicle_id`) DISABLE NOVALIDATE
);

drop table if exists `driving_school`.`Customers`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Customers` (
    `customer_id` INT,
    `customer_address_id` INT NOT NULL,
    `customer_status_code` STRING NOT NULL,
    `date_became_customer` TIMESTAMP,
    `date_of_birth` TIMESTAMP,
    `first_name` STRING,
    `last_name` STRING,
    `amount_outstanding` DOUBLE,
    `email_address` STRING,
    `phone_number` STRING,
    `cell_mobile_phone_number` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_address_id`) REFERENCES `driving_school`.`Addresses` (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `driving_school`.`Customer_Payments`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Customer_Payments` (
    `customer_id` INT NOT NULL,
    `datetime_payment` TIMESTAMP NOT NULL,
    `payment_method_code` STRING NOT NULL,
    `amount_payment` DOUBLE,
    PRIMARY KEY (`customer_id`, `datetime_payment`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `driving_school`.`Customers` (`customer_id`) DISABLE NOVALIDATE
);

drop table if exists `driving_school`.`Lessons`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Lessons` (
    `lesson_id` INT,
    `customer_id` INT NOT NULL,
    `lesson_status_code` STRING NOT NULL,
    `staff_id` INT,
    `vehicle_id` INT NOT NULL,
    `lesson_date` TIMESTAMP,
    `lesson_time` STRING,
    `price` DOUBLE,
    PRIMARY KEY (`lesson_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `driving_school`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `driving_school`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`vehicle_id`) REFERENCES `driving_school`.`Vehicles` (`vehicle_id`) DISABLE NOVALIDATE
);
