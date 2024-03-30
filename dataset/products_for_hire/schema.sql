-- Dialect: MySQL | Database: products_for_hire | Table Count: 7

CREATE DATABASE IF NOT EXISTS `products_for_hire`;

DROP TABLE IF EXISTS `products_for_hire`.`Discount_Coupons`;
CREATE TABLE `products_for_hire`.`Discount_Coupons` (
    `coupon_id` INTEGER,
    `date_issued` DATETIME,
    `coupon_amount` DECIMAL(19,4),
    PRIMARY KEY (`coupon_id`)
);

DROP TABLE IF EXISTS `products_for_hire`.`Customers`;
CREATE TABLE `products_for_hire`.`Customers` (
    `customer_id` INTEGER,
    `coupon_id` INTEGER NOT NULL,
    `good_or_bad_customer` VARCHAR(4),
    `first_name` VARCHAR(80),
    `last_name` VARCHAR(80),
    `gender_mf` VARCHAR(1),
    `date_became_customer` DATETIME,
    `date_last_hire` DATETIME,
    PRIMARY KEY (`customer_id`),
    FOREIGN KEY (`coupon_id`) REFERENCES `products_for_hire`.`Discount_Coupons` (`coupon_id`)
);

DROP TABLE IF EXISTS `products_for_hire`.`Bookings`;
CREATE TABLE `products_for_hire`.`Bookings` (
    `booking_id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `booking_status_code` VARCHAR(15) NOT NULL,
    `returned_damaged_yn` VARCHAR(40),
    `booking_start_date` DATETIME,
    `booking_end_date` DATETIME,
    `count_hired` VARCHAR(40),
    `amount_payable` DECIMAL(19,4),
    `amount_of_discount` DECIMAL(19,4),
    `amount_outstanding` DECIMAL(19,4),
    `amount_of_refund` DECIMAL(19,4),
    PRIMARY KEY (`booking_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `products_for_hire`.`Customers` (`customer_id`)
);

DROP TABLE IF EXISTS `products_for_hire`.`Products_for_Hire`;
CREATE TABLE `products_for_hire`.`Products_for_Hire` (
    `product_id` INTEGER,
    `product_type_code` VARCHAR(15) NOT NULL,
    `daily_hire_cost` DECIMAL(19,4),
    `product_name` VARCHAR(80),
    `product_description` VARCHAR(255),
    PRIMARY KEY (`product_id`)
);

DROP TABLE IF EXISTS `products_for_hire`.`Payments`;
CREATE TABLE `products_for_hire`.`Payments` (
    `payment_id` INTEGER,
    `booking_id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `payment_type_code` VARCHAR(15) NOT NULL,
    `amount_paid_in_full_yn` VARCHAR(1),
    `payment_date` DATETIME,
    `amount_due` DECIMAL(19,4),
    `amount_paid` DECIMAL(19,4),
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `products_for_hire`.`Customers` (`customer_id`),
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`)
);

DROP TABLE IF EXISTS `products_for_hire`.`Products_Booked`;
CREATE TABLE `products_for_hire`.`Products_Booked` (
    `booking_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `returned_yn` VARCHAR(1),
    `returned_late_yn` VARCHAR(1),
    `booked_count` INTEGER,
    `booked_amount` FLOAT,
    PRIMARY KEY (`booking_id`, `product_id`),
    FOREIGN KEY (`product_id`) REFERENCES `products_for_hire`.`Products_for_Hire` (`product_id`),
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`)
);

DROP TABLE IF EXISTS `products_for_hire`.`View_Product_Availability`;
CREATE TABLE `products_for_hire`.`View_Product_Availability` (
    `product_id` INTEGER NOT NULL,
    `booking_id` INTEGER NOT NULL,
    `status_date` DATETIME,
    `available_yn` VARCHAR(1),
    PRIMARY KEY (`status_date`),
    FOREIGN KEY (`product_id`) REFERENCES `products_for_hire`.`Products_for_Hire` (`product_id`),
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`)
);
