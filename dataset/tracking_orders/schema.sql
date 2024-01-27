CREATE DATABASE IF NOT EXISTS `tracking_orders`;

drop table if exists `tracking_orders`.`Customers`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Customers` (
    `customer_id` INT,
    `customer_name` STRING,
    `customer_details` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Customers.csv' INTO TABLE `tracking_orders`.`Customers`;


drop table if exists `tracking_orders`.`Invoices`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Invoices` (
    `invoice_number` INT,
    `invoice_date` TIMESTAMP,
    `invoice_details` STRING,
    PRIMARY KEY (`invoice_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Invoices.csv' INTO TABLE `tracking_orders`.`Invoices`;


drop table if exists `tracking_orders`.`Orders`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_status` STRING NOT NULL,
    `date_order_placed` TIMESTAMP NOT NULL,
    `order_details` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `tracking_orders`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Orders.csv' INTO TABLE `tracking_orders`.`Orders`;


drop table if exists `tracking_orders`.`Products`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Products` (
    `product_id` INT,
    `product_name` STRING,
    `product_details` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Products.csv' INTO TABLE `tracking_orders`.`Products`;


drop table if exists `tracking_orders`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Order_Items` (
    `order_item_id` INT,
    `product_id` INT NOT NULL,
    `order_id` INT NOT NULL,
    `order_item_status` STRING NOT NULL,
    `order_item_details` STRING,
    PRIMARY KEY (`order_item_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `tracking_orders`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `tracking_orders`.`Orders` (`order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Order_Items.csv' INTO TABLE `tracking_orders`.`Order_Items`;


drop table if exists `tracking_orders`.`Shipments`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Shipments` (
    `shipment_id` INT,
    `order_id` INT NOT NULL,
    `invoice_number` INT NOT NULL,
    `shipment_tracking_number` STRING,
    `shipment_date` TIMESTAMP,
    `other_shipment_details` STRING,
    PRIMARY KEY (`shipment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`invoice_number`) REFERENCES `tracking_orders`.`Invoices` (`invoice_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `tracking_orders`.`Orders` (`order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Shipments.csv' INTO TABLE `tracking_orders`.`Shipments`;


drop table if exists `tracking_orders`.`Shipment_Items`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Shipment_Items` (
    `shipment_id` INT NOT NULL,
    `order_item_id` INT NOT NULL,
    FOREIGN KEY (`shipment_id`) REFERENCES `tracking_orders`.`Shipments` (`shipment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_item_id`) REFERENCES `tracking_orders`.`Order_Items` (`order_item_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Shipment_Items.csv' INTO TABLE `tracking_orders`.`Shipment_Items`;

