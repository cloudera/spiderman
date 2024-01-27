CREATE DATABASE IF NOT EXISTS `storm_record`;

drop table if exists `storm_record`.`storm`;
CREATE TABLE IF NOT EXISTS `storm_record`.`storm` (
    `Storm_ID` INT,
    `Name` STRING,
    `Dates_active` STRING,
    `Max_speed` INT,
    `Damage_millions_USD` REAL,
    `Number_Deaths` INT,
    PRIMARY KEY (`Storm_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/storm_record/data/storm.csv' INTO TABLE `storm_record`.`storm`;


drop table if exists `storm_record`.`region`;
CREATE TABLE IF NOT EXISTS `storm_record`.`region` (
    `Region_id` INT,
    `Region_code` STRING,
    `Region_name` STRING,
    PRIMARY KEY (`Region_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/storm_record/data/region.csv' INTO TABLE `storm_record`.`region`;


drop table if exists `storm_record`.`affected_region`;
CREATE TABLE IF NOT EXISTS `storm_record`.`affected_region` (
    `Region_id` INT,
    `Storm_ID` INT,
    `Number_city_affected` REAL,
    PRIMARY KEY (`Region_id`, `Storm_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Storm_ID`) REFERENCES `storm_record`.`storm` (`Storm_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Region_id`) REFERENCES `storm_record`.`region` (`Region_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/storm_record/data/affected_region.csv' INTO TABLE `storm_record`.`affected_region`;

