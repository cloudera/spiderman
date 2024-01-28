CREATE DATABASE IF NOT EXISTS `customers_and_addresses`;

drop table if exists `customers_and_addresses`.`Addresses`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Addresses` (
    `address_id` INT,
    `address_content` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    `other_address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `customers_and_addresses`.`Products`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Products` (
    `product_id` INT,
    `product_details` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
);

drop table if exists `customers_and_addresses`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Customers` (
    `customer_id` INT,
    `payment_method` STRING NOT NULL,
    `customer_name` STRING,
    `date_became_customer` TIMESTAMP,
    `other_customer_details` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
);

drop table if exists `customers_and_addresses`.`Customer_Addresses`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Customer_Addresses` (
    `customer_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_address_from` TIMESTAMP NOT NULL,
    `address_type` STRING NOT NULL,
    `date_address_to` TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_addresses`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `customers_and_addresses`.`Addresses` (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `customers_and_addresses`.`Customer_Contact_Channels`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Customer_Contact_Channels` (
    `customer_id` INT NOT NULL,
    `channel_code` STRING NOT NULL,
    `active_from_date` TIMESTAMP NOT NULL,
    `active_to_date` TIMESTAMP,
    `contact_number` STRING NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_addresses`.`Customers` (`customer_id`) DISABLE NOVALIDATE
);

drop table if exists `customers_and_addresses`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Customer_Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_status` STRING NOT NULL,
    `order_date` TIMESTAMP,
    `order_details` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_addresses`.`Customers` (`customer_id`) DISABLE NOVALIDATE
);

drop table if exists `customers_and_addresses`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Order_Items` (
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `order_quantity` STRING,
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_addresses`.`Customer_Orders` (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_addresses`.`Products` (`product_id`) DISABLE NOVALIDATE
);
