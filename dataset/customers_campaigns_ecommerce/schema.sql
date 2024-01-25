drop table if exists `customers_campaigns_ecommerce`.`Premises`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Premises` (
    `premise_id` INT,
    `premises_type` STRING NOT NULL,
    `premise_details` STRING,
    PRIMARY KEY (`premise_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Premises.csv' INTO TABLE `customers_campaigns_ecommerce`.`Premises`;


drop table if exists `customers_campaigns_ecommerce`.`Products`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Products` (
    `product_id` INT,
    `product_category` STRING NOT NULL,
    `product_name` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Products.csv' INTO TABLE `customers_campaigns_ecommerce`.`Products`;


drop table if exists `customers_campaigns_ecommerce`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Customers` (
    `customer_id` INT,
    `payment_method` STRING NOT NULL,
    `customer_name` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    `customer_address` STRING,
    `customer_login` STRING,
    `customer_password` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Customers.csv' INTO TABLE `customers_campaigns_ecommerce`.`Customers`;


drop table if exists `customers_campaigns_ecommerce`.`Mailshot_Campaigns`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Mailshot_Campaigns` (
    `mailshot_id` INT,
    `product_category` STRING,
    `mailshot_name` STRING,
    `mailshot_start_date` TIMESTAMP,
    `mailshot_end_date` TIMESTAMP,
    PRIMARY KEY (`mailshot_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Mailshot_Campaigns.csv' INTO TABLE `customers_campaigns_ecommerce`.`Mailshot_Campaigns`;


drop table if exists `customers_campaigns_ecommerce`.`Customer_Addresses`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Customer_Addresses` (
    `customer_id` INT NOT NULL,
    `premise_id` INT NOT NULL,
    `date_address_from` TIMESTAMP NOT NULL,
    `address_type_code` STRING NOT NULL,
    `date_address_to` TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`premise_id`) REFERENCES `customers_campaigns_ecommerce`.`Premises` (`premise_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Customer_Addresses.csv' INTO TABLE `customers_campaigns_ecommerce`.`Customer_Addresses`;


drop table if exists `customers_campaigns_ecommerce`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Customer_Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_status_code` STRING NOT NULL,
    `shipping_method_code` STRING NOT NULL,
    `order_placed_datetime` TIMESTAMP NOT NULL,
    `order_delivered_datetime` TIMESTAMP,
    `order_shipping_charges` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Customer_Orders.csv' INTO TABLE `customers_campaigns_ecommerce`.`Customer_Orders`;


drop table if exists `customers_campaigns_ecommerce`.`Mailshot_Customers`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Mailshot_Customers` (
    `mailshot_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `outcome_code` STRING NOT NULL,
    `mailshot_customer_date` TIMESTAMP,
    FOREIGN KEY (`mailshot_id`) REFERENCES `customers_campaigns_ecommerce`.`Mailshot_Campaigns` (`mailshot_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Mailshot_Customers.csv' INTO TABLE `customers_campaigns_ecommerce`.`Mailshot_Customers`;


drop table if exists `customers_campaigns_ecommerce`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Order_Items` (
    `item_id` INT NOT NULL,
    `order_item_status_code` STRING NOT NULL,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `item_status_code` STRING,
    `item_delivered_datetime` TIMESTAMP,
    `item_order_quantity` STRING,
    FOREIGN KEY (`order_id`) REFERENCES `customers_campaigns_ecommerce`.`Customer_Orders` (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customers_campaigns_ecommerce`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Order_Items.csv' INTO TABLE `customers_campaigns_ecommerce`.`Order_Items`;

