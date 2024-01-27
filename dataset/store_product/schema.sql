CREATE DATABASE IF NOT EXISTS `store_product`;

drop table if exists `store_product`.`product`;
CREATE TABLE IF NOT EXISTS `store_product`.`product` (
    `product_id` INT,
    `product` STRING,
    `dimensions` STRING,
    `dpi` REAL,
    `pages_per_minute_color` REAL,
    `max_page_size` STRING,
    `interface` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/product.csv' INTO TABLE `store_product`.`product`;


drop table if exists `store_product`.`store`;
CREATE TABLE IF NOT EXISTS `store_product`.`store` (
    `Store_ID` INT,
    `Store_Name` STRING,
    `Type` STRING,
    `Area_size` REAL,
    `Number_of_product_category` REAL,
    `Ranking` INT,
    PRIMARY KEY (`Store_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/store.csv' INTO TABLE `store_product`.`store`;


drop table if exists `store_product`.`district`;
CREATE TABLE IF NOT EXISTS `store_product`.`district` (
    `District_ID` INT,
    `District_name` STRING,
    `Headquartered_City` STRING,
    `City_Population` REAL,
    `City_Area` REAL,
    PRIMARY KEY (`District_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/district.csv' INTO TABLE `store_product`.`district`;


drop table if exists `store_product`.`store_product`;
CREATE TABLE IF NOT EXISTS `store_product`.`store_product` (
    `Store_ID` INT,
    `Product_ID` INT,
    PRIMARY KEY (`Store_ID`, `Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Product_ID`) REFERENCES `store_product`.`product` (`Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Store_ID`) REFERENCES `store_product`.`store` (`Store_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/store_product.csv' INTO TABLE `store_product`.`store_product`;


drop table if exists `store_product`.`store_district`;
CREATE TABLE IF NOT EXISTS `store_product`.`store_district` (
    `Store_ID` INT,
    `District_ID` INT,
    PRIMARY KEY (`Store_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`District_ID`) REFERENCES `store_product`.`district` (`District_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Store_ID`) REFERENCES `store_product`.`store` (`Store_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/store_district.csv' INTO TABLE `store_product`.`store_district`;

