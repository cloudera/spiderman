CREATE DATABASE IF NOT EXISTS `architecture`;

drop table if exists `architecture`.`architect`;
CREATE TABLE IF NOT EXISTS `architecture`.`architect` (
    `id` INT,
    `name` STRING,
    `nationality` STRING,
    `gender` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `architecture`.`bridge`;
CREATE TABLE IF NOT EXISTS `architecture`.`bridge` (
    `architect_id` INT,
    `id` INT,
    `name` STRING,
    `location` STRING,
    `length_meters` DOUBLE,
    `length_feet` DOUBLE,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`architect_id`) REFERENCES `architecture`.`architect` (`id`) DISABLE NOVALIDATE
);

drop table if exists `architecture`.`mill`;
CREATE TABLE IF NOT EXISTS `architecture`.`mill` (
    `architect_id` INT,
    `id` INT,
    `location` STRING,
    `name` STRING,
    `type` STRING,
    `built_year` INT,
    `notes` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`architect_id`) REFERENCES `architecture`.`architect` (`id`) DISABLE NOVALIDATE
);
