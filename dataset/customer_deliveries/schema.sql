CREATE DATABASE IF NOT EXISTS `customer_deliveries`;

drop table if exists `customer_deliveries`.`Products`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Products` (
    `product_id` INT,
    `product_name` STRING,
    `product_price` DECIMAL(19,4),
    `product_description` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Products.csv' INTO TABLE `customer_deliveries`.`Products`;


drop table if exists `customer_deliveries`.`Addresses`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Addresses` (
    `address_id` INT,
    `address_details` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Addresses.csv' INTO TABLE `customer_deliveries`.`Addresses`;


drop table if exists `customer_deliveries`.`Customers`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Customers` (
    `customer_id` INT,
    `payment_method` STRING NOT NULL,
    `customer_name` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    `date_became_customer` TIMESTAMP,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Customers.csv' INTO TABLE `customer_deliveries`.`Customers`;


drop table if exists `customer_deliveries`.`Regular_Orders`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Regular_Orders` (
    `regular_order_id` INT,
    `distributer_id` INT NOT NULL,
    PRIMARY KEY (`regular_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`distributer_id`) REFERENCES `customer_deliveries`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Regular_Orders.csv' INTO TABLE `customer_deliveries`.`Regular_Orders`;


drop table if exists `customer_deliveries`.`Regular_Order_Products`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Regular_Order_Products` (
    `regular_order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    FOREIGN KEY (`regular_order_id`) REFERENCES `customer_deliveries`.`Regular_Orders` (`regular_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customer_deliveries`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Regular_Order_Products.csv' INTO TABLE `customer_deliveries`.`Regular_Order_Products`;


drop table if exists `customer_deliveries`.`Actual_Orders`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Actual_Orders` (
    `actual_order_id` INT,
    `order_status_code` STRING NOT NULL,
    `regular_order_id` INT NOT NULL,
    `actual_order_date` TIMESTAMP,
    PRIMARY KEY (`actual_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`regular_order_id`) REFERENCES `customer_deliveries`.`Regular_Orders` (`regular_order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Actual_Orders.csv' INTO TABLE `customer_deliveries`.`Actual_Orders`;


drop table if exists `customer_deliveries`.`Actual_Order_Products`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Actual_Order_Products` (
    `actual_order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    FOREIGN KEY (`actual_order_id`) REFERENCES `customer_deliveries`.`Actual_Orders` (`actual_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customer_deliveries`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Actual_Order_Products.csv' INTO TABLE `customer_deliveries`.`Actual_Order_Products`;


drop table if exists `customer_deliveries`.`Customer_Addresses`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Customer_Addresses` (
    `customer_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP NOT NULL,
    `address_type` STRING NOT NULL,
    `date_to` TIMESTAMP,
    FOREIGN KEY (`address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customer_deliveries`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Customer_Addresses.csv' INTO TABLE `customer_deliveries`.`Customer_Addresses`;


drop table if exists `customer_deliveries`.`Delivery_Routes`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Delivery_Routes` (
    `route_id` INT,
    `route_name` STRING,
    `other_route_details` STRING,
    PRIMARY KEY (`route_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Delivery_Routes.csv' INTO TABLE `customer_deliveries`.`Delivery_Routes`;


drop table if exists `customer_deliveries`.`Delivery_Route_Locations`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Delivery_Route_Locations` (
    `location_code` STRING,
    `route_id` INT NOT NULL,
    `location_address_id` INT NOT NULL,
    `location_name` STRING,
    PRIMARY KEY (`location_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`route_id`) REFERENCES `customer_deliveries`.`Delivery_Routes` (`route_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`location_address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Delivery_Route_Locations.csv' INTO TABLE `customer_deliveries`.`Delivery_Route_Locations`;


drop table if exists `customer_deliveries`.`Trucks`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Trucks` (
    `truck_id` INT,
    `truck_licence_number` STRING,
    `truck_details` STRING,
    PRIMARY KEY (`truck_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Trucks.csv' INTO TABLE `customer_deliveries`.`Trucks`;


drop table if exists `customer_deliveries`.`Employees`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Employees` (
    `employee_id` INT,
    `employee_address_id` INT NOT NULL,
    `employee_name` STRING,
    `employee_phone` STRING,
    PRIMARY KEY (`employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`employee_address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Employees.csv' INTO TABLE `customer_deliveries`.`Employees`;


drop table if exists `customer_deliveries`.`Order_Deliveries`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Order_Deliveries` (
    `location_code` STRING NOT NULL,
    `actual_order_id` INT NOT NULL,
    `delivery_status_code` STRING NOT NULL,
    `driver_employee_id` INT NOT NULL,
    `truck_id` INT NOT NULL,
    `delivery_date` TIMESTAMP,
    FOREIGN KEY (`driver_employee_id`) REFERENCES `customer_deliveries`.`Employees` (`employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`location_code`) REFERENCES `customer_deliveries`.`Delivery_Route_Locations` (`location_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`actual_order_id`) REFERENCES `customer_deliveries`.`Actual_Orders` (`actual_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`truck_id`) REFERENCES `customer_deliveries`.`Trucks` (`truck_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Order_Deliveries.csv' INTO TABLE `customer_deliveries`.`Order_Deliveries`;

