CREATE DATABASE IF NOT EXISTS `products_for_hire`;

drop table if exists `products_for_hire`.`Discount_Coupons`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Discount_Coupons` (
    `coupon_id` INT,
    `date_issued` TIMESTAMP,
    `coupon_amount` DECIMAL(19,4),
    PRIMARY KEY (`coupon_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Discount_Coupons.csv' INTO TABLE `products_for_hire`.`Discount_Coupons`;


drop table if exists `products_for_hire`.`Customers`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Customers` (
    `customer_id` INT,
    `coupon_id` INT NOT NULL,
    `good_or_bad_customer` STRING,
    `first_name` STRING,
    `last_name` STRING,
    `gender_mf` STRING,
    `date_became_customer` TIMESTAMP,
    `date_last_hire` TIMESTAMP,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`coupon_id`) REFERENCES `products_for_hire`.`Discount_Coupons` (`coupon_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Customers.csv' INTO TABLE `products_for_hire`.`Customers`;


drop table if exists `products_for_hire`.`Bookings`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Bookings` (
    `booking_id` INT,
    `customer_id` INT NOT NULL,
    `booking_status_code` STRING NOT NULL,
    `returned_damaged_yn` STRING,
    `booking_start_date` TIMESTAMP,
    `booking_end_date` TIMESTAMP,
    `count_hired` STRING,
    `amount_payable` DECIMAL(19,4),
    `amount_of_discount` DECIMAL(19,4),
    `amount_outstanding` DECIMAL(19,4),
    `amount_of_refund` DECIMAL(19,4),
    PRIMARY KEY (`booking_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `products_for_hire`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Bookings.csv' INTO TABLE `products_for_hire`.`Bookings`;


drop table if exists `products_for_hire`.`Products_for_Hire`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Products_for_Hire` (
    `product_id` INT,
    `product_type_code` STRING NOT NULL,
    `daily_hire_cost` DECIMAL(19,4),
    `product_name` STRING,
    `product_description` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Products_for_Hire.csv' INTO TABLE `products_for_hire`.`Products_for_Hire`;


drop table if exists `products_for_hire`.`Payments`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Payments` (
    `payment_id` INT,
    `booking_id` INT,
    `customer_id` INT NOT NULL,
    `payment_type_code` STRING NOT NULL,
    `amount_paid_in_full_yn` STRING,
    `payment_date` TIMESTAMP,
    `amount_due` DECIMAL(19,4),
    `amount_paid` DECIMAL(19,4),
    PRIMARY KEY (`payment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `products_for_hire`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Payments.csv' INTO TABLE `products_for_hire`.`Payments`;


drop table if exists `products_for_hire`.`Products_Booked`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Products_Booked` (
    `booking_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `returned_yn` STRING,
    `returned_late_yn` STRING,
    `booked_count` INT,
    `booked_amount` DECIMAL,
    PRIMARY KEY (`booking_id`, `product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `products_for_hire`.`Products_for_Hire` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Products_Booked.csv' INTO TABLE `products_for_hire`.`Products_Booked`;


drop table if exists `products_for_hire`.`View_Product_Availability`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`View_Product_Availability` (
    `product_id` INT NOT NULL,
    `booking_id` INT NOT NULL,
    `status_date` TIMESTAMP,
    `available_yn` STRING,
    PRIMARY KEY (`status_date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `products_for_hire`.`Products_for_Hire` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/View_Product_Availability.csv' INTO TABLE `products_for_hire`.`View_Product_Availability`;

