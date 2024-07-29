-- Dialect: MySQL | Database: product_catalog | Table Count: 5

CREATE DATABASE IF NOT EXISTS `product_catalog`;

DROP TABLE IF EXISTS `product_catalog`.`Attribute_Definitions`;
CREATE TABLE `product_catalog`.`Attribute_Definitions` (
    `attribute_id` INTEGER,
    `attribute_name` VARCHAR(30),
    `attribute_data_type` VARCHAR(10),
    PRIMARY KEY (`attribute_id`)
);

DROP TABLE IF EXISTS `product_catalog`.`Catalogs`;
CREATE TABLE `product_catalog`.`Catalogs` (
    `catalog_id` INTEGER,
    `catalog_name` VARCHAR(50),
    `catalog_publisher` VARCHAR(80),
    `date_of_publication` DATETIME,
    `date_of_latest_revision` DATETIME,
    PRIMARY KEY (`catalog_id`)
);

DROP TABLE IF EXISTS `product_catalog`.`Catalog_Structure`;
CREATE TABLE `product_catalog`.`Catalog_Structure` (
    `catalog_level_number` INTEGER,
    `catalog_id` INTEGER NOT NULL,
    `catalog_level_name` VARCHAR(50),
    PRIMARY KEY (`catalog_level_number`),
    FOREIGN KEY (`catalog_id`) REFERENCES `product_catalog`.`Catalogs` (`catalog_id`)
);

DROP TABLE IF EXISTS `product_catalog`.`Catalog_Contents`;
CREATE TABLE `product_catalog`.`Catalog_Contents` (
    `catalog_entry_id` INTEGER,
    `catalog_level_number` INTEGER NOT NULL,
    `parent_entry_id` INTEGER,
    `previous_entry_id` INTEGER,
    `next_entry_id` INTEGER,
    `catalog_entry_name` VARCHAR(80),
    `product_stock_number` VARCHAR(50),
    `price_in_dollars` DOUBLE,
    `price_in_euros` DOUBLE,
    `price_in_pounds` DOUBLE,
    `capacity` VARCHAR(20),
    `length` VARCHAR(20),
    `height` VARCHAR(20),
    `width` VARCHAR(20),
    PRIMARY KEY (`catalog_entry_id`),
    FOREIGN KEY (`catalog_level_number`) REFERENCES `product_catalog`.`Catalog_Structure` (`catalog_level_number`)
);

DROP TABLE IF EXISTS `product_catalog`.`Catalog_Contents_Additional_Attributes`;
CREATE TABLE `product_catalog`.`Catalog_Contents_Additional_Attributes` (
    `catalog_entry_id` INTEGER NOT NULL,
    `catalog_level_number` INTEGER NOT NULL,
    `attribute_id` INTEGER NOT NULL,
    `attribute_value` VARCHAR(255) NOT NULL,
    FOREIGN KEY (`catalog_level_number`) REFERENCES `product_catalog`.`Catalog_Structure` (`catalog_level_number`),
    FOREIGN KEY (`catalog_entry_id`) REFERENCES `product_catalog`.`Catalog_Contents` (`catalog_entry_id`)
);
