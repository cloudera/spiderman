-- Dialect: MySQL | Database: customers_and_products_contacts | Table Count: 7

CREATE DATABASE IF NOT EXISTS `customers_and_products_contacts`;

DROP TABLE IF EXISTS `customers_and_products_contacts`.`Addresses`;
CREATE TABLE `customers_and_products_contacts`.`Addresses` (
    `address_id` INTEGER,
    `line_1_number_building` VARCHAR(80),
    `city` VARCHAR(50),
    `zip_postcode` VARCHAR(20),
    `state_province_county` VARCHAR(50),
    `country` VARCHAR(50),
    PRIMARY KEY (`address_id`)
);

DROP TABLE IF EXISTS `customers_and_products_contacts`.`Products`;
CREATE TABLE `customers_and_products_contacts`.`Products` (
    `product_id` INTEGER,
    `product_type_code` VARCHAR(15),
    `product_name` VARCHAR(80),
    `product_price` DOUBLE,
    PRIMARY KEY (`product_id`)
);

DROP TABLE IF EXISTS `customers_and_products_contacts`.`Customers`;
CREATE TABLE `customers_and_products_contacts`.`Customers` (
    `customer_id` INTEGER,
    `payment_method_code` VARCHAR(15),
    `customer_number` VARCHAR(20),
    `customer_name` VARCHAR(80),
    `customer_address` VARCHAR(255),
    `customer_phone` VARCHAR(80),
    `customer_email` VARCHAR(80),
    PRIMARY KEY (`customer_id`)
);

DROP TABLE IF EXISTS `customers_and_products_contacts`.`Contacts`;
CREATE TABLE `customers_and_products_contacts`.`Contacts` (
    `contact_id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `gender` VARCHAR(1),
    `first_name` VARCHAR(80),
    `last_name` VARCHAR(50),
    `contact_phone` VARCHAR(80),
    PRIMARY KEY (`contact_id`)
);

DROP TABLE IF EXISTS `customers_and_products_contacts`.`Customer_Address_History`;
CREATE TABLE `customers_and_products_contacts`.`Customer_Address_History` (
    `customer_id` INTEGER NOT NULL,
    `address_id` INTEGER NOT NULL,
    `date_from` DATETIME NOT NULL,
    `date_to` DATETIME,
    FOREIGN KEY (`address_id`) REFERENCES `customers_and_products_contacts`.`Addresses` (`address_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_products_contacts`.`Customers` (`customer_id`)
);

DROP TABLE IF EXISTS `customers_and_products_contacts`.`Customer_Orders`;
CREATE TABLE `customers_and_products_contacts`.`Customer_Orders` (
    `order_id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `order_date` DATETIME NOT NULL,
    `order_status_code` VARCHAR(15),
    PRIMARY KEY (`order_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_products_contacts`.`Customers` (`customer_id`)
);

DROP TABLE IF EXISTS `customers_and_products_contacts`.`Order_Items`;
CREATE TABLE `customers_and_products_contacts`.`Order_Items` (
    `order_item_id` INTEGER NOT NULL,
    `order_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `order_quantity` VARCHAR(80),
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_products_contacts`.`Customer_Orders` (`order_id`),
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_products_contacts`.`Products` (`product_id`)
);
