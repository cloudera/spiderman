-- Dialect: MySQL | Database: tracking_orders | Table Count: 7

CREATE DATABASE IF NOT EXISTS `tracking_orders`;

DROP TABLE IF EXISTS `tracking_orders`.`Customers`;
CREATE TABLE `tracking_orders`.`Customers` (
    `customer_id` INTEGER,
    `customer_name` VARCHAR(80),
    `customer_details` VARCHAR(255),
    PRIMARY KEY (`customer_id`)
);

DROP TABLE IF EXISTS `tracking_orders`.`Invoices`;
CREATE TABLE `tracking_orders`.`Invoices` (
    `invoice_number` INTEGER,
    `invoice_date` DATETIME,
    `invoice_details` VARCHAR(255),
    PRIMARY KEY (`invoice_number`)
);

DROP TABLE IF EXISTS `tracking_orders`.`Orders`;
CREATE TABLE `tracking_orders`.`Orders` (
    `order_id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `order_status` VARCHAR(10) NOT NULL,
    `date_order_placed` DATETIME NOT NULL,
    `order_details` VARCHAR(255),
    PRIMARY KEY (`order_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `tracking_orders`.`Customers` (`customer_id`)
);

DROP TABLE IF EXISTS `tracking_orders`.`Products`;
CREATE TABLE `tracking_orders`.`Products` (
    `product_id` INTEGER,
    `product_name` VARCHAR(80),
    `product_details` VARCHAR(255),
    PRIMARY KEY (`product_id`)
);

DROP TABLE IF EXISTS `tracking_orders`.`Order_Items`;
CREATE TABLE `tracking_orders`.`Order_Items` (
    `order_item_id` INTEGER,
    `product_id` INTEGER NOT NULL,
    `order_id` INTEGER NOT NULL,
    `order_item_status` VARCHAR(10) NOT NULL,
    `order_item_details` VARCHAR(255),
    PRIMARY KEY (`order_item_id`),
    FOREIGN KEY (`product_id`) REFERENCES `tracking_orders`.`Products` (`product_id`),
    FOREIGN KEY (`order_id`) REFERENCES `tracking_orders`.`Orders` (`order_id`)
);

DROP TABLE IF EXISTS `tracking_orders`.`Shipments`;
CREATE TABLE `tracking_orders`.`Shipments` (
    `shipment_id` INTEGER,
    `order_id` INTEGER NOT NULL,
    `invoice_number` INTEGER NOT NULL,
    `shipment_tracking_number` VARCHAR(80),
    `shipment_date` DATETIME,
    `other_shipment_details` VARCHAR(255),
    PRIMARY KEY (`shipment_id`),
    FOREIGN KEY (`invoice_number`) REFERENCES `tracking_orders`.`Invoices` (`invoice_number`),
    FOREIGN KEY (`order_id`) REFERENCES `tracking_orders`.`Orders` (`order_id`)
);

DROP TABLE IF EXISTS `tracking_orders`.`Shipment_Items`;
CREATE TABLE `tracking_orders`.`Shipment_Items` (
    `shipment_id` INTEGER NOT NULL,
    `order_item_id` INTEGER NOT NULL,
    FOREIGN KEY (`shipment_id`) REFERENCES `tracking_orders`.`Shipments` (`shipment_id`),
    FOREIGN KEY (`order_item_id`) REFERENCES `tracking_orders`.`Order_Items` (`order_item_id`)
);
