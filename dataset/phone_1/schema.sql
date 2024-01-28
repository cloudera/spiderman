CREATE DATABASE IF NOT EXISTS `phone_1`;

drop table if exists `phone_1`.`chip_model`;
CREATE TABLE IF NOT EXISTS `phone_1`.`chip_model` (
    `Model_name` STRING,
    `Launch_year` DOUBLE,
    `RAM_MiB` DOUBLE,
    `ROM_MiB` DOUBLE,
    `Slots` STRING,
    `WiFi` STRING,
    `Bluetooth` STRING,
    PRIMARY KEY (`Model_name`) DISABLE NOVALIDATE
);

drop table if exists `phone_1`.`screen_mode`;
CREATE TABLE IF NOT EXISTS `phone_1`.`screen_mode` (
    `Graphics_mode` DOUBLE,
    `Char_cells` STRING,
    `Pixels` STRING,
    `Hardware_colours` DOUBLE,
    `used_kb` DOUBLE,
    `map` STRING,
    `Type` STRING,
    PRIMARY KEY (`Graphics_mode`) DISABLE NOVALIDATE
);

drop table if exists `phone_1`.`phone`;
CREATE TABLE IF NOT EXISTS `phone_1`.`phone` (
    `Company_name` STRING,
    `Hardware_Model_name` STRING,
    `Accreditation_type` STRING,
    `Accreditation_level` STRING,
    `Date` STRING,
    `chip_model` STRING,
    `screen_mode` DOUBLE,
    PRIMARY KEY (`Hardware_Model_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`chip_model`) REFERENCES `phone_1`.`chip_model` (`Model_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`screen_mode`) REFERENCES `phone_1`.`screen_mode` (`Graphics_mode`) DISABLE NOVALIDATE
);
