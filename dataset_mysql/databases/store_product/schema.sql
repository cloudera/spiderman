-- Dialect: mysql | Database: store_product | Table Count: 5

CREATE TABLE `store_product`.`product` (
    `product_id` INT,
    `product` TEXT,
    `dimensions` TEXT,
    `dpi` REAL,
    `pages_per_minute_color` REAL,
    `max_page_size` TEXT,
    `interface` TEXT,
    PRIMARY KEY (`product_id`)
);

CREATE TABLE `store_product`.`store` (
    `Store_ID` INT,
    `Store_Name` TEXT,
    `Type` TEXT,
    `Area_size` REAL,
    `Number_of_product_category` REAL,
    `Ranking` INT,
    PRIMARY KEY (`Store_ID`)
);

CREATE TABLE `store_product`.`district` (
    `District_ID` INT,
    `District_name` TEXT,
    `Headquartered_City` TEXT,
    `City_Population` REAL,
    `City_Area` REAL,
    PRIMARY KEY (`District_ID`)
);

CREATE TABLE `store_product`.`store_product` (
    `Store_ID` INT,
    `Product_ID` INT,
    PRIMARY KEY (`Store_ID`, `Product_ID`),
    FOREIGN KEY (`Product_ID`) REFERENCES `store_product`.`product` (`Product_ID`),
    FOREIGN KEY (`Store_ID`) REFERENCES `store_product`.`store` (`Store_ID`)
);

CREATE TABLE `store_product`.`store_district` (
    `Store_ID` INT,
    `District_ID` INT,
    PRIMARY KEY (`Store_ID`),
    FOREIGN KEY (`District_ID`) REFERENCES `store_product`.`district` (`District_ID`),
    FOREIGN KEY (`Store_ID`) REFERENCES `store_product`.`store` (`Store_ID`)
);
