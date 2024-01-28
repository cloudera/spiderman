CREATE DATABASE IF NOT EXISTS `department_store`;

drop table if exists `department_store`.`Addresses`;
CREATE TABLE IF NOT EXISTS `department_store`.`Addresses` (
    `address_id` INT,
    `address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Staff`;
CREATE TABLE IF NOT EXISTS `department_store`.`Staff` (
    `staff_id` INT,
    `staff_gender` STRING,
    `staff_name` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Suppliers`;
CREATE TABLE IF NOT EXISTS `department_store`.`Suppliers` (
    `supplier_id` INT,
    `supplier_name` STRING,
    `supplier_phone` STRING,
    PRIMARY KEY (`supplier_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Department_Store_Chain`;
CREATE TABLE IF NOT EXISTS `department_store`.`Department_Store_Chain` (
    `dept_store_chain_id` INT,
    `dept_store_chain_name` STRING,
    PRIMARY KEY (`dept_store_chain_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Customers`;
CREATE TABLE IF NOT EXISTS `department_store`.`Customers` (
    `customer_id` INT,
    `payment_method_code` STRING NOT NULL,
    `customer_code` STRING,
    `customer_name` STRING,
    `customer_address` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Products`;
CREATE TABLE IF NOT EXISTS `department_store`.`Products` (
    `product_id` INT,
    `product_type_code` STRING NOT NULL,
    `product_name` STRING,
    `product_price` DECIMAL(19,4),
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Supplier_Addresses`;
CREATE TABLE IF NOT EXISTS `department_store`.`Supplier_Addresses` (
    `supplier_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP NOT NULL,
    `date_to` TIMESTAMP,
    PRIMARY KEY (`supplier_id`, `address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`supplier_id`) REFERENCES `department_store`.`Suppliers` (`supplier_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `department_store`.`Addresses` (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Customer_Addresses`;
CREATE TABLE IF NOT EXISTS `department_store`.`Customer_Addresses` (
    `customer_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP NOT NULL,
    `date_to` TIMESTAMP,
    PRIMARY KEY (`customer_id`, `address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `department_store`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `department_store`.`Addresses` (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `department_store`.`Customer_Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_status_code` STRING NOT NULL,
    `order_date` TIMESTAMP NOT NULL,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `department_store`.`Customers` (`customer_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Department_Stores`;
CREATE TABLE IF NOT EXISTS `department_store`.`Department_Stores` (
    `dept_store_id` INT,
    `dept_store_chain_id` INT,
    `store_name` STRING,
    `store_address` STRING,
    `store_phone` STRING,
    `store_email` STRING,
    PRIMARY KEY (`dept_store_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_store_chain_id`) REFERENCES `department_store`.`Department_Store_Chain` (`dept_store_chain_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Departments`;
CREATE TABLE IF NOT EXISTS `department_store`.`Departments` (
    `department_id` INT,
    `dept_store_id` INT NOT NULL,
    `department_name` STRING,
    PRIMARY KEY (`department_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_store_id`) REFERENCES `department_store`.`Department_Stores` (`dept_store_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `department_store`.`Order_Items` (
    `order_item_id` INT,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    PRIMARY KEY (`order_item_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `department_store`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `department_store`.`Customer_Orders` (`order_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Product_Suppliers`;
CREATE TABLE IF NOT EXISTS `department_store`.`Product_Suppliers` (
    `product_id` INT NOT NULL,
    `supplier_id` INT NOT NULL,
    `date_supplied_from` TIMESTAMP NOT NULL,
    `date_supplied_to` TIMESTAMP,
    `total_amount_purchased` STRING,
    `total_value_purchased` DECIMAL(19,4),
    PRIMARY KEY (`product_id`, `supplier_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `department_store`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`supplier_id`) REFERENCES `department_store`.`Suppliers` (`supplier_id`) DISABLE NOVALIDATE
);

drop table if exists `department_store`.`Staff_Department_Assignments`;
CREATE TABLE IF NOT EXISTS `department_store`.`Staff_Department_Assignments` (
    `staff_id` INT NOT NULL,
    `department_id` INT NOT NULL,
    `date_assigned_from` TIMESTAMP NOT NULL,
    `job_title_code` STRING NOT NULL,
    `date_assigned_to` TIMESTAMP,
    PRIMARY KEY (`staff_id`, `department_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `department_store`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`department_id`) REFERENCES `department_store`.`Departments` (`department_id`) DISABLE NOVALIDATE
);
