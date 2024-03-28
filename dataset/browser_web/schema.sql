-- Dialect: MySQL | Database: browser_web | Table Count: 3

CREATE DATABASE IF NOT EXISTS `browser_web`;

DROP TABLE IF EXISTS `browser_web`.`Web_client_accelerator`;
CREATE TABLE `browser_web`.`Web_client_accelerator` (
    `id` INT,
    `name` TEXT,
    `Operating_system` TEXT,
    `Client` TEXT,
    `Connection` TEXT,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `browser_web`.`browser`;
CREATE TABLE `browser_web`.`browser` (
    `id` INT,
    `name` TEXT,
    `market_share` REAL,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `browser_web`.`accelerator_compatible_browser`;
CREATE TABLE `browser_web`.`accelerator_compatible_browser` (
    `accelerator_id` INT,
    `browser_id` INT,
    `compatible_since_year` INT,
    PRIMARY KEY (`accelerator_id`, `browser_id`),
    FOREIGN KEY (`browser_id`) REFERENCES `browser_web`.`browser` (`id`),
    FOREIGN KEY (`accelerator_id`) REFERENCES `browser_web`.`Web_client_accelerator` (`id`)
);
