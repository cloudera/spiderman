-- Dialect: MySQL | Database: products_gen_characteristics | Table Count: 6

CREATE DATABASE IF NOT EXISTS `products_gen_characteristics`;

DROP TABLE IF EXISTS `products_gen_characteristics`.`Ref_Characteristic_Types`;
CREATE TABLE `products_gen_characteristics`.`Ref_Characteristic_Types` (
    `characteristic_type_code` VARCHAR(15),
    `characteristic_type_description` VARCHAR(80),
    PRIMARY KEY (`characteristic_type_code`)
);

DROP TABLE IF EXISTS `products_gen_characteristics`.`Ref_Colors`;
CREATE TABLE `products_gen_characteristics`.`Ref_Colors` (
    `color_code` VARCHAR(15),
    `color_description` VARCHAR(80),
    PRIMARY KEY (`color_code`)
);

DROP TABLE IF EXISTS `products_gen_characteristics`.`Ref_Product_Categories`;
CREATE TABLE `products_gen_characteristics`.`Ref_Product_Categories` (
    `product_category_code` VARCHAR(15),
    `product_category_description` VARCHAR(80),
    `unit_of_measure` VARCHAR(20),
    PRIMARY KEY (`product_category_code`)
);

DROP TABLE IF EXISTS `products_gen_characteristics`.`Characteristics`;
CREATE TABLE `products_gen_characteristics`.`Characteristics` (
    `characteristic_id` INTEGER,
    `characteristic_type_code` VARCHAR(15) NOT NULL,
    `characteristic_data_type` VARCHAR(10),
    `characteristic_name` VARCHAR(80),
    `other_characteristic_details` VARCHAR(255),
    PRIMARY KEY (`characteristic_id`),
    FOREIGN KEY (`characteristic_type_code`) REFERENCES `products_gen_characteristics`.`Ref_Characteristic_Types` (`characteristic_type_code`)
);

DROP TABLE IF EXISTS `products_gen_characteristics`.`Products`;
CREATE TABLE `products_gen_characteristics`.`Products` (
    `product_id` INTEGER,
    `color_code` VARCHAR(15) NOT NULL,
    `product_category_code` VARCHAR(15) NOT NULL,
    `product_name` VARCHAR(80),
    `typical_buying_price` VARCHAR(20),
    `typical_selling_price` VARCHAR(20),
    `product_description` VARCHAR(255),
    `other_product_details` VARCHAR(255),
    PRIMARY KEY (`product_id`),
    FOREIGN KEY (`color_code`) REFERENCES `products_gen_characteristics`.`Ref_Colors` (`color_code`),
    FOREIGN KEY (`product_category_code`) REFERENCES `products_gen_characteristics`.`Ref_Product_Categories` (`product_category_code`)
);

DROP TABLE IF EXISTS `products_gen_characteristics`.`Product_Characteristics`;
CREATE TABLE `products_gen_characteristics`.`Product_Characteristics` (
    `product_id` INTEGER NOT NULL,
    `characteristic_id` INTEGER NOT NULL,
    `product_characteristic_value` VARCHAR(50),
    FOREIGN KEY (`product_id`) REFERENCES `products_gen_characteristics`.`Products` (`product_id`),
    FOREIGN KEY (`characteristic_id`) REFERENCES `products_gen_characteristics`.`Characteristics` (`characteristic_id`)
);
