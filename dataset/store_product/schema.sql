CREATE DATABASE IF NOT EXISTS `store_product`;

drop table if exists `store_product`.`product`;
CREATE TABLE IF NOT EXISTS `store_product`.`product` (
    `product_id` INT,
    `product` STRING,
    `dimensions` STRING,
    `dpi` DOUBLE,
    `pages_per_minute_color` DOUBLE,
    `max_page_size` STRING,
    `interface` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
);

drop table if exists `store_product`.`store`;
CREATE TABLE IF NOT EXISTS `store_product`.`store` (
    `Store_ID` INT,
    `Store_Name` STRING,
    `Type` STRING,
    `Area_size` DOUBLE,
    `Number_of_product_category` DOUBLE,
    `Ranking` INT,
    PRIMARY KEY (`Store_ID`) DISABLE NOVALIDATE
);

drop table if exists `store_product`.`district`;
CREATE TABLE IF NOT EXISTS `store_product`.`district` (
    `District_ID` INT,
    `District_name` STRING,
    `Headquartered_City` STRING,
    `City_Population` DOUBLE,
    `City_Area` DOUBLE,
    PRIMARY KEY (`District_ID`) DISABLE NOVALIDATE
);

drop table if exists `store_product`.`store_product`;
CREATE TABLE IF NOT EXISTS `store_product`.`store_product` (
    `Store_ID` INT,
    `Product_ID` INT,
    PRIMARY KEY (`Store_ID`, `Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Product_ID`) REFERENCES `store_product`.`product` (`Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Store_ID`) REFERENCES `store_product`.`store` (`Store_ID`) DISABLE NOVALIDATE
);

drop table if exists `store_product`.`store_district`;
CREATE TABLE IF NOT EXISTS `store_product`.`store_district` (
    `Store_ID` INT,
    `District_ID` INT,
    PRIMARY KEY (`Store_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`District_ID`) REFERENCES `store_product`.`district` (`District_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Store_ID`) REFERENCES `store_product`.`store` (`Store_ID`) DISABLE NOVALIDATE
);
