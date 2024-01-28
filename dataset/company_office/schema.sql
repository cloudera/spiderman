CREATE DATABASE IF NOT EXISTS `company_office`;

drop table if exists `company_office`.`buildings`;
CREATE TABLE IF NOT EXISTS `company_office`.`buildings` (
    `id` INT,
    `name` STRING,
    `City` STRING,
    `Height` INT,
    `Stories` INT,
    `Status` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `company_office`.`Companies`;
CREATE TABLE IF NOT EXISTS `company_office`.`Companies` (
    `id` INT,
    `name` STRING,
    `Headquarters` STRING,
    `Industry` STRING,
    `Sales_billion` DOUBLE,
    `Profits_billion` DOUBLE,
    `Assets_billion` DOUBLE,
    `Market_Value_billion` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `company_office`.`Office_locations`;
CREATE TABLE IF NOT EXISTS `company_office`.`Office_locations` (
    `building_id` INT,
    `company_id` INT,
    `move_in_year` INT,
    PRIMARY KEY (`building_id`, `company_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`company_id`) REFERENCES `company_office`.`Companies` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building_id`) REFERENCES `company_office`.`buildings` (`id`) DISABLE NOVALIDATE
);
