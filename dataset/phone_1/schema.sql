CREATE DATABASE IF NOT EXISTS `phone_1`;

drop table if exists `phone_1`.`chip_model`;
CREATE TABLE IF NOT EXISTS `phone_1`.`chip_model` (
    `Model_name` STRING,
    `Launch_year` REAL,
    `RAM_MiB` REAL,
    `ROM_MiB` REAL,
    `Slots` STRING,
    `WiFi` STRING,
    `Bluetooth` STRING,
    PRIMARY KEY (`Model_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_1/data/chip_model.csv' INTO TABLE `phone_1`.`chip_model`;


drop table if exists `phone_1`.`screen_mode`;
CREATE TABLE IF NOT EXISTS `phone_1`.`screen_mode` (
    `Graphics_mode` REAL,
    `Char_cells` STRING,
    `Pixels` STRING,
    `Hardware_colours` REAL,
    `used_kb` REAL,
    `map` STRING,
    `Type` STRING,
    PRIMARY KEY (`Graphics_mode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_1/data/screen_mode.csv' INTO TABLE `phone_1`.`screen_mode`;


drop table if exists `phone_1`.`phone`;
CREATE TABLE IF NOT EXISTS `phone_1`.`phone` (
    `Company_name` STRING,
    `Hardware_Model_name` STRING,
    `Accreditation_type` STRING,
    `Accreditation_level` STRING,
    `Date` STRING,
    `chip_model` STRING,
    `screen_mode` REAL,
    PRIMARY KEY (`Hardware_Model_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`chip_model`) REFERENCES `phone_1`.`chip_model` (`Model_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`screen_mode`) REFERENCES `phone_1`.`screen_mode` (`Graphics_mode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_1/data/phone.csv' INTO TABLE `phone_1`.`phone`;

