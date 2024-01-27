CREATE DATABASE IF NOT EXISTS `customers_and_invoices`;

drop table if exists `customers_and_invoices`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Customers` (
    `customer_id` INT,
    `customer_first_name` STRING,
    `customer_middle_initial` STRING,
    `customer_last_name` STRING,
    `gender` STRING,
    `email_address` STRING,
    `login_name` STRING,
    `login_password` STRING,
    `phone_number` STRING,
    `town_city` STRING,
    `state_county_province` STRING,
    `country` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Customers.csv' INTO TABLE `customers_and_invoices`.`Customers`;


drop table if exists `customers_and_invoices`.`Orders`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `date_order_placed` TIMESTAMP NOT NULL,
    `order_details` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_invoices`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Orders.csv' INTO TABLE `customers_and_invoices`.`Orders`;


drop table if exists `customers_and_invoices`.`Invoices`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Invoices` (
    `invoice_number` INT,
    `order_id` INT NOT NULL,
    `invoice_date` TIMESTAMP,
    PRIMARY KEY (`invoice_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_invoices`.`Orders` (`order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Invoices.csv' INTO TABLE `customers_and_invoices`.`Invoices`;


drop table if exists `customers_and_invoices`.`Accounts`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Accounts` (
    `account_id` INT,
    `customer_id` INT NOT NULL,
    `date_account_opened` TIMESTAMP,
    `account_name` STRING,
    `other_account_details` STRING,
    PRIMARY KEY (`account_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_invoices`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Accounts.csv' INTO TABLE `customers_and_invoices`.`Accounts`;


drop table if exists `customers_and_invoices`.`Product_Categories`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Product_Categories` (
    `production_type_code` STRING,
    `product_type_description` STRING,
    `vat_rating` DECIMAL(19,4),
    PRIMARY KEY (`production_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Product_Categories.csv' INTO TABLE `customers_and_invoices`.`Product_Categories`;


drop table if exists `customers_and_invoices`.`Products`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Products` (
    `product_id` INT,
    `parent_product_id` INT,
    `production_type_code` STRING NOT NULL,
    `unit_price` DECIMAL(19,4),
    `product_name` STRING,
    `product_color` STRING,
    `product_size` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`production_type_code`) REFERENCES `customers_and_invoices`.`Product_Categories` (`production_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Products.csv' INTO TABLE `customers_and_invoices`.`Products`;


drop table if exists `customers_and_invoices`.`Financial_Transactions`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Financial_Transactions` (
    `transaction_id` INT NOT NULL,
    `account_id` INT NOT NULL,
    `invoice_number` INT,
    `transaction_type` STRING NOT NULL,
    `transaction_date` TIMESTAMP,
    `transaction_amount` DECIMAL(19,4),
    `transaction_comment` STRING,
    `other_transaction_details` STRING,
    FOREIGN KEY (`account_id`) REFERENCES `customers_and_invoices`.`Accounts` (`account_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`invoice_number`) REFERENCES `customers_and_invoices`.`Invoices` (`invoice_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Financial_Transactions.csv' INTO TABLE `customers_and_invoices`.`Financial_Transactions`;


drop table if exists `customers_and_invoices`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Order_Items` (
    `order_item_id` INT,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `product_quantity` STRING,
    `other_order_item_details` STRING,
    PRIMARY KEY (`order_item_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_invoices`.`Orders` (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_invoices`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Order_Items.csv' INTO TABLE `customers_and_invoices`.`Order_Items`;


drop table if exists `customers_and_invoices`.`Invoice_Line_Items`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Invoice_Line_Items` (
    `order_item_id` INT NOT NULL,
    `invoice_number` INT NOT NULL,
    `product_id` INT NOT NULL,
    `product_title` STRING,
    `product_quantity` STRING,
    `product_price` DECIMAL(19,4),
    `derived_product_cost` DECIMAL(19,4),
    `derived_vat_payable` DECIMAL(19,4),
    `derived_total_cost` DECIMAL(19,4),
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_invoices`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`invoice_number`) REFERENCES `customers_and_invoices`.`Invoices` (`invoice_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_item_id`) REFERENCES `customers_and_invoices`.`Order_Items` (`order_item_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Invoice_Line_Items.csv' INTO TABLE `customers_and_invoices`.`Invoice_Line_Items`;

