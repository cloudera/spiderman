-- Dialect: MySQL | Database: customers_campaigns_ecommerce | Table Count: 8

CREATE DATABASE IF NOT EXISTS `customers_campaigns_ecommerce`;

DROP TABLE IF EXISTS `customers_campaigns_ecommerce`.`Premises`;
CREATE TABLE `customers_campaigns_ecommerce`.`Premises` (
    `premise_id` INTEGER,
    `premises_type` VARCHAR(15) NOT NULL,
    `premise_details` VARCHAR(255),
    PRIMARY KEY (`premise_id`)
);

DROP TABLE IF EXISTS `customers_campaigns_ecommerce`.`Products`;
CREATE TABLE `customers_campaigns_ecommerce`.`Products` (
    `product_id` INTEGER,
    `product_category` VARCHAR(15) NOT NULL,
    `product_name` VARCHAR(80),
    PRIMARY KEY (`product_id`)
);

DROP TABLE IF EXISTS `customers_campaigns_ecommerce`.`Customers`;
CREATE TABLE `customers_campaigns_ecommerce`.`Customers` (
    `customer_id` INTEGER,
    `payment_method` VARCHAR(15) NOT NULL,
    `customer_name` VARCHAR(80),
    `customer_phone` VARCHAR(80),
    `customer_email` VARCHAR(80),
    `customer_address` VARCHAR(255),
    `customer_login` VARCHAR(80),
    `customer_password` VARCHAR(10),
    PRIMARY KEY (`customer_id`)
);

DROP TABLE IF EXISTS `customers_campaigns_ecommerce`.`Mailshot_Campaigns`;
CREATE TABLE `customers_campaigns_ecommerce`.`Mailshot_Campaigns` (
    `mailshot_id` INTEGER,
    `product_category` VARCHAR(15),
    `mailshot_name` VARCHAR(80),
    `mailshot_start_date` DATETIME,
    `mailshot_end_date` DATETIME,
    PRIMARY KEY (`mailshot_id`)
);

DROP TABLE IF EXISTS `customers_campaigns_ecommerce`.`Customer_Addresses`;
CREATE TABLE `customers_campaigns_ecommerce`.`Customer_Addresses` (
    `customer_id` INTEGER NOT NULL,
    `premise_id` INTEGER NOT NULL,
    `date_address_from` DATETIME NOT NULL,
    `address_type_code` VARCHAR(15) NOT NULL,
    `date_address_to` DATETIME,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`),
    FOREIGN KEY (`premise_id`) REFERENCES `customers_campaigns_ecommerce`.`Premises` (`premise_id`)
);

DROP TABLE IF EXISTS `customers_campaigns_ecommerce`.`Customer_Orders`;
CREATE TABLE `customers_campaigns_ecommerce`.`Customer_Orders` (
    `order_id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `order_status_code` VARCHAR(15) NOT NULL,
    `shipping_method_code` VARCHAR(15) NOT NULL,
    `order_placed_datetime` DATETIME NOT NULL,
    `order_delivered_datetime` DATETIME,
    `order_shipping_charges` VARCHAR(255),
    PRIMARY KEY (`order_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`)
);

DROP TABLE IF EXISTS `customers_campaigns_ecommerce`.`Mailshot_Customers`;
CREATE TABLE `customers_campaigns_ecommerce`.`Mailshot_Customers` (
    `mailshot_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `outcome_code` VARCHAR(15) NOT NULL,
    `mailshot_customer_date` DATETIME,
    FOREIGN KEY (`mailshot_id`) REFERENCES `customers_campaigns_ecommerce`.`Mailshot_Campaigns` (`mailshot_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`)
);

DROP TABLE IF EXISTS `customers_campaigns_ecommerce`.`Order_Items`;
CREATE TABLE `customers_campaigns_ecommerce`.`Order_Items` (
    `item_id` INTEGER NOT NULL,
    `order_item_status_code` VARCHAR(15) NOT NULL,
    `order_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `item_status_code` VARCHAR(15),
    `item_delivered_datetime` DATETIME,
    `item_order_quantity` VARCHAR(80),
    FOREIGN KEY (`order_id`) REFERENCES `customers_campaigns_ecommerce`.`Customer_Orders` (`order_id`),
    FOREIGN KEY (`product_id`) REFERENCES `customers_campaigns_ecommerce`.`Products` (`product_id`)
);
