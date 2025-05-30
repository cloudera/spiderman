-- Dialect: mysql | Database: customer_deliveries | Table Count: 13

CREATE TABLE `customer_deliveries`.`Products` (
    `product_id` INTEGER,
    `product_name` VARCHAR(20),
    `product_price` DECIMAL(19,4),
    `product_description` VARCHAR(255),
    PRIMARY KEY (`product_id`)
);

CREATE TABLE `customer_deliveries`.`Addresses` (
    `address_id` INTEGER,
    `address_details` VARCHAR(80),
    `city` VARCHAR(50),
    `zip_postcode` VARCHAR(20),
    `state_province_county` VARCHAR(50),
    `country` VARCHAR(50),
    PRIMARY KEY (`address_id`)
);

CREATE TABLE `customer_deliveries`.`Customers` (
    `customer_id` INTEGER,
    `payment_method` VARCHAR(10) NOT NULL,
    `customer_name` VARCHAR(80),
    `customer_phone` VARCHAR(80),
    `customer_email` VARCHAR(80),
    `date_became_customer` DATETIME,
    PRIMARY KEY (`customer_id`)
);

CREATE TABLE `customer_deliveries`.`Regular_Orders` (
    `regular_order_id` INTEGER,
    `distributer_id` INTEGER NOT NULL,
    PRIMARY KEY (`regular_order_id`),
    FOREIGN KEY (`distributer_id`) REFERENCES `customer_deliveries`.`Customers` (`customer_id`)
);

CREATE TABLE `customer_deliveries`.`Regular_Order_Products` (
    `regular_order_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    FOREIGN KEY (`regular_order_id`) REFERENCES `customer_deliveries`.`Regular_Orders` (`regular_order_id`),
    FOREIGN KEY (`product_id`) REFERENCES `customer_deliveries`.`Products` (`product_id`)
);

CREATE TABLE `customer_deliveries`.`Actual_Orders` (
    `actual_order_id` INTEGER,
    `order_status_code` VARCHAR(10) NOT NULL,
    `regular_order_id` INTEGER NOT NULL,
    `actual_order_date` DATETIME,
    PRIMARY KEY (`actual_order_id`),
    FOREIGN KEY (`regular_order_id`) REFERENCES `customer_deliveries`.`Regular_Orders` (`regular_order_id`)
);

CREATE TABLE `customer_deliveries`.`Actual_Order_Products` (
    `actual_order_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    FOREIGN KEY (`actual_order_id`) REFERENCES `customer_deliveries`.`Actual_Orders` (`actual_order_id`),
    FOREIGN KEY (`product_id`) REFERENCES `customer_deliveries`.`Products` (`product_id`)
);

CREATE TABLE `customer_deliveries`.`Customer_Addresses` (
    `customer_id` INTEGER NOT NULL,
    `address_id` INTEGER NOT NULL,
    `date_from` DATETIME NOT NULL,
    `address_type` VARCHAR(10) NOT NULL,
    `date_to` DATETIME,
    FOREIGN KEY (`address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `customer_deliveries`.`Customers` (`customer_id`)
);

CREATE TABLE `customer_deliveries`.`Delivery_Routes` (
    `route_id` INTEGER,
    `route_name` VARCHAR(50),
    `other_route_details` VARCHAR(255),
    PRIMARY KEY (`route_id`)
);

CREATE TABLE `customer_deliveries`.`Delivery_Route_Locations` (
    `location_code` VARCHAR(20),
    `route_id` INTEGER NOT NULL,
    `location_address_id` INTEGER NOT NULL,
    `location_name` VARCHAR(50),
    PRIMARY KEY (`location_code`),
    FOREIGN KEY (`route_id`) REFERENCES `customer_deliveries`.`Delivery_Routes` (`route_id`),
    FOREIGN KEY (`location_address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`)
);

CREATE TABLE `customer_deliveries`.`Trucks` (
    `truck_id` INTEGER,
    `truck_licence_number` VARCHAR(20),
    `truck_details` VARCHAR(255),
    PRIMARY KEY (`truck_id`)
);

CREATE TABLE `customer_deliveries`.`Employees` (
    `employee_id` INTEGER,
    `employee_address_id` INTEGER NOT NULL,
    `employee_name` VARCHAR(80),
    `employee_phone` VARCHAR(80),
    PRIMARY KEY (`employee_id`),
    FOREIGN KEY (`employee_address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`)
);

CREATE TABLE `customer_deliveries`.`Order_Deliveries` (
    `location_code` VARCHAR(20) NOT NULL,
    `actual_order_id` INTEGER NOT NULL,
    `delivery_status_code` VARCHAR(10) NOT NULL,
    `driver_employee_id` INTEGER NOT NULL,
    `truck_id` INTEGER NOT NULL,
    `delivery_date` DATETIME,
    FOREIGN KEY (`driver_employee_id`) REFERENCES `customer_deliveries`.`Employees` (`employee_id`),
    FOREIGN KEY (`location_code`) REFERENCES `customer_deliveries`.`Delivery_Route_Locations` (`location_code`),
    FOREIGN KEY (`actual_order_id`) REFERENCES `customer_deliveries`.`Actual_Orders` (`actual_order_id`),
    FOREIGN KEY (`truck_id`) REFERENCES `customer_deliveries`.`Trucks` (`truck_id`)
);
