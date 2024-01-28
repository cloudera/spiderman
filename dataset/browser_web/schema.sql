CREATE DATABASE IF NOT EXISTS `browser_web`;

drop table if exists `browser_web`.`Web_client_accelerator`;
CREATE TABLE IF NOT EXISTS `browser_web`.`Web_client_accelerator` (
    `id` INT,
    `name` STRING,
    `Operating_system` STRING,
    `Client` STRING,
    `Connection` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `browser_web`.`browser`;
CREATE TABLE IF NOT EXISTS `browser_web`.`browser` (
    `id` INT,
    `name` STRING,
    `market_share` DOUBLE,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `browser_web`.`accelerator_compatible_browser`;
CREATE TABLE IF NOT EXISTS `browser_web`.`accelerator_compatible_browser` (
    `accelerator_id` INT,
    `browser_id` INT,
    `compatible_since_year` INT,
    PRIMARY KEY (`accelerator_id`, `browser_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`browser_id`) REFERENCES `browser_web`.`browser` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`accelerator_id`) REFERENCES `browser_web`.`Web_client_accelerator` (`id`) DISABLE NOVALIDATE
);
