-- Dialect: MySQL | Database: storm_record | Table Count: 3

CREATE DATABASE IF NOT EXISTS `storm_record`;

DROP TABLE IF EXISTS `storm_record`.`storm`;
CREATE TABLE `storm_record`.`storm` (
    `Storm_ID` INT,
    `Name` TEXT,
    `Dates_active` TEXT,
    `Max_speed` INT,
    `Damage_millions_USD` REAL,
    `Number_Deaths` INT,
    PRIMARY KEY (`Storm_ID`)
);

DROP TABLE IF EXISTS `storm_record`.`region`;
CREATE TABLE `storm_record`.`region` (
    `Region_id` INT,
    `Region_code` TEXT,
    `Region_name` TEXT,
    PRIMARY KEY (`Region_id`)
);

DROP TABLE IF EXISTS `storm_record`.`affected_region`;
CREATE TABLE `storm_record`.`affected_region` (
    `Region_id` INT,
    `Storm_ID` INT,
    `Number_city_affected` REAL,
    PRIMARY KEY (`Region_id`, `Storm_ID`),
    FOREIGN KEY (`Storm_ID`) REFERENCES `storm_record`.`storm` (`Storm_ID`),
    FOREIGN KEY (`Region_id`) REFERENCES `storm_record`.`region` (`Region_id`)
);
