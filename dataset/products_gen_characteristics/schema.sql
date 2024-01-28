CREATE DATABASE IF NOT EXISTS `products_gen_characteristics`;

drop table if exists `products_gen_characteristics`.`Ref_Characteristic_Types`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Ref_Characteristic_Types` (
    `characteristic_type_code` STRING,
    `characteristic_type_description` STRING,
    PRIMARY KEY (`characteristic_type_code`) DISABLE NOVALIDATE
);

drop table if exists `products_gen_characteristics`.`Ref_Colors`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Ref_Colors` (
    `color_code` STRING,
    `color_description` STRING,
    PRIMARY KEY (`color_code`) DISABLE NOVALIDATE
);

drop table if exists `products_gen_characteristics`.`Ref_Product_Categories`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Ref_Product_Categories` (
    `product_category_code` STRING,
    `product_category_description` STRING,
    `unit_of_measure` STRING,
    PRIMARY KEY (`product_category_code`) DISABLE NOVALIDATE
);

drop table if exists `products_gen_characteristics`.`Characteristics`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Characteristics` (
    `characteristic_id` INT,
    `characteristic_type_code` STRING NOT NULL,
    `characteristic_data_type` STRING,
    `characteristic_name` STRING,
    `other_characteristic_details` STRING,
    PRIMARY KEY (`characteristic_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`characteristic_type_code`) REFERENCES `products_gen_characteristics`.`Ref_Characteristic_Types` (`characteristic_type_code`) DISABLE NOVALIDATE
);

drop table if exists `products_gen_characteristics`.`Products`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Products` (
    `product_id` INT,
    `color_code` STRING NOT NULL,
    `product_category_code` STRING NOT NULL,
    `product_name` STRING,
    `typical_buying_price` STRING,
    `typical_selling_price` STRING,
    `product_description` STRING,
    `other_product_details` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`color_code`) REFERENCES `products_gen_characteristics`.`Ref_Colors` (`color_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_category_code`) REFERENCES `products_gen_characteristics`.`Ref_Product_Categories` (`product_category_code`) DISABLE NOVALIDATE
);

drop table if exists `products_gen_characteristics`.`Product_Characteristics`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Product_Characteristics` (
    `product_id` INT NOT NULL,
    `characteristic_id` INT NOT NULL,
    `product_characteristic_value` STRING,
    FOREIGN KEY (`product_id`) REFERENCES `products_gen_characteristics`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`characteristic_id`) REFERENCES `products_gen_characteristics`.`Characteristics` (`characteristic_id`) DISABLE NOVALIDATE
);
