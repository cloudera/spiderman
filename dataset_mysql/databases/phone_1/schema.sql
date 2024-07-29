-- Dialect: MySQL | Database: phone_1 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `phone_1`;

DROP TABLE IF EXISTS `phone_1`.`chip_model`;
CREATE TABLE `phone_1`.`chip_model` (
    `Model_name` VARCHAR(50),
    `Launch_year` REAL,
    `RAM_MiB` REAL,
    `ROM_MiB` REAL,
    `Slots` TEXT,
    `WiFi` TEXT,
    `Bluetooth` TEXT,
    PRIMARY KEY (`Model_name`)
);

DROP TABLE IF EXISTS `phone_1`.`screen_mode`;
CREATE TABLE `phone_1`.`screen_mode` (
    `Graphics_mode` REAL,
    `Char_cells` TEXT,
    `Pixels` TEXT,
    `Hardware_colours` REAL,
    `used_kb` REAL,
    `map` TEXT,
    `Type` TEXT,
    PRIMARY KEY (`Graphics_mode`)
);

DROP TABLE IF EXISTS `phone_1`.`phone`;
CREATE TABLE `phone_1`.`phone` (
    `Company_name` TEXT,
    `Hardware_Model_name` VARCHAR(50),
    `Accreditation_type` TEXT,
    `Accreditation_level` TEXT,
    `Date` TEXT,
    `chip_model` VARCHAR(20),
    `screen_mode` REAL,
    PRIMARY KEY (`Hardware_Model_name`),
    FOREIGN KEY (`chip_model`) REFERENCES `phone_1`.`chip_model` (`Model_name`),
    FOREIGN KEY (`screen_mode`) REFERENCES `phone_1`.`screen_mode` (`Graphics_mode`)
);
