CREATE DATABASE IF NOT EXISTS `customers_and_products_contacts`;

drop table if exists `customers_and_products_contacts`.`Addresses`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Addresses` (
    `address_id` INT,
    `line_1_number_building` STRING,
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
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Addresses.csv' INTO TABLE `customers_and_products_contacts`.`Addresses`;


drop table if exists `customers_and_products_contacts`.`Products`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Products` (
    `product_id` INT,
    `product_type_code` STRING,
    `product_name` STRING,
    `product_price` REAL,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Products.csv' INTO TABLE `customers_and_products_contacts`.`Products`;


drop table if exists `customers_and_products_contacts`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Customers` (
    `customer_id` INT,
    `payment_method_code` STRING,
    `customer_number` STRING,
    `customer_name` STRING,
    `customer_address` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Customers.csv' INTO TABLE `customers_and_products_contacts`.`Customers`;


drop table if exists `customers_and_products_contacts`.`Contacts`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Contacts` (
    `contact_id` INT,
    `customer_id` INT NOT NULL,
    `gender` STRING,
    `first_name` STRING,
    `last_name` STRING,
    `contact_phone` STRING,
    PRIMARY KEY (`contact_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Contacts.csv' INTO TABLE `customers_and_products_contacts`.`Contacts`;


drop table if exists `customers_and_products_contacts`.`Customer_Address_History`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Customer_Address_History` (
    `customer_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP NOT NULL,
    `date_to` TIMESTAMP,
    FOREIGN KEY (`address_id`) REFERENCES `customers_and_products_contacts`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_products_contacts`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Customer_Address_History.csv' INTO TABLE `customers_and_products_contacts`.`Customer_Address_History`;


drop table if exists `customers_and_products_contacts`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Customer_Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_date` TIMESTAMP NOT NULL,
    `order_status_code` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_products_contacts`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Customer_Orders.csv' INTO TABLE `customers_and_products_contacts`.`Customer_Orders`;


drop table if exists `customers_and_products_contacts`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Order_Items` (
    `order_item_id` INT NOT NULL,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `order_quantity` STRING,
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_products_contacts`.`Customer_Orders` (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_products_contacts`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Order_Items.csv' INTO TABLE `customers_and_products_contacts`.`Order_Items`;

