-- Dialect: MySQL | Database: sakila_1 | Table Count: 16

CREATE DATABASE IF NOT EXISTS `sakila_1`;

DROP TABLE IF EXISTS `sakila_1`.`actor`;
CREATE TABLE `sakila_1`.`actor` (
    `actor_id` INT NOT NULL,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`actor_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`country`;
CREATE TABLE `sakila_1`.`country` (
    `country_id` INT NOT NULL,
    `country` VARCHAR(50) NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`country_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`city`;
CREATE TABLE `sakila_1`.`city` (
    `city_id` INT NOT NULL,
    `city` VARCHAR(50) NOT NULL,
    `country_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`city_id`),
    FOREIGN KEY (`country_id`) REFERENCES `sakila_1`.`country` (`country_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`address`;
CREATE TABLE `sakila_1`.`address` (
    `address_id` INT NOT NULL,
    `address` VARCHAR(50) NOT NULL,
    `address2` VARCHAR(50) DEFAULT NULL,
    `district` VARCHAR(20) NOT NULL,
    `city_id` INT NOT NULL,
    `postal_code` VARCHAR(10) DEFAULT NULL,
    `phone` VARCHAR(20) NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`address_id`),
    FOREIGN KEY (`city_id`) REFERENCES `sakila_1`.`city` (`city_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`category`;
CREATE TABLE `sakila_1`.`category` (
    `category_id` SMALLINT NOT NULL,
    `name` VARCHAR(25) NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`category_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`staff`;
CREATE TABLE `sakila_1`.`staff` (
    `staff_id` SMALLINT NOT NULL,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `address_id` INT NOT NULL,
    `picture` BINARY DEFAULT NULL,
    `email` VARCHAR(50) DEFAULT NULL,
    `store_id` SMALLINT NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT TRUE,
    `username` VARCHAR(16) NOT NULL,
    `password` VARCHAR(40) DEFAULT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`staff_id`),
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`store`;
CREATE TABLE `sakila_1`.`store` (
    `store_id` SMALLINT NOT NULL,
    `manager_staff_id` SMALLINT NOT NULL,
    `address_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`store_id`),
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`),
    FOREIGN KEY (`manager_staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`customer`;
CREATE TABLE `sakila_1`.`customer` (
    `customer_id` INT NOT NULL,
    `store_id` SMALLINT NOT NULL,
    `first_name` VARCHAR(45) NOT NULL,
    `last_name` VARCHAR(45) NOT NULL,
    `email` VARCHAR(50) DEFAULT NULL,
    `address_id` INT NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT TRUE,
    `create_date` TIMESTAMP NOT NULL,
    `last_update` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`customer_id`),
    FOREIGN KEY (`store_id`) REFERENCES `sakila_1`.`store` (`store_id`),
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`language`;
CREATE TABLE `sakila_1`.`language` (
    `language_id` SMALLINT NOT NULL,
    `name` CHAR(20) NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`language_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`film`;
CREATE TABLE `sakila_1`.`film` (
    `film_id` INT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT DEFAULT NULL,
    `release_year` INT DEFAULT NULL,
    `language_id` SMALLINT NOT NULL,
    `original_language_id` SMALLINT DEFAULT NULL,
    `rental_duration` SMALLINT NOT NULL DEFAULT 3,
    `rental_rate` DECIMAL(4,2) NOT NULL DEFAULT 4.99,
    `length` INT DEFAULT NULL,
    `replacement_cost` DECIMAL(5,2) NOT NULL DEFAULT 19.99,
    `rating` VARCHAR(10) DEFAULT 'G',
    `special_features` TEXT DEFAULT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`film_id`),
    FOREIGN KEY (`original_language_id`) REFERENCES `sakila_1`.`language` (`language_id`),
    FOREIGN KEY (`language_id`) REFERENCES `sakila_1`.`language` (`language_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`film_actor`;
CREATE TABLE `sakila_1`.`film_actor` (
    `actor_id` INT NOT NULL,
    `film_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`actor_id`, `film_id`),
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`),
    FOREIGN KEY (`actor_id`) REFERENCES `sakila_1`.`actor` (`actor_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`film_category`;
CREATE TABLE `sakila_1`.`film_category` (
    `film_id` INT NOT NULL,
    `category_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`film_id`, `category_id`),
    FOREIGN KEY (`category_id`) REFERENCES `sakila_1`.`category` (`category_id`),
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`film_text`;
CREATE TABLE `sakila_1`.`film_text` (
    `film_id` SMALLINT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT,
    PRIMARY KEY (`film_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`inventory`;
CREATE TABLE `sakila_1`.`inventory` (
    `inventory_id` INT NOT NULL,
    `film_id` INT NOT NULL,
    `store_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`inventory_id`),
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`),
    FOREIGN KEY (`store_id`) REFERENCES `sakila_1`.`store` (`store_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`rental`;
CREATE TABLE `sakila_1`.`rental` (
    `rental_id` INT NOT NULL,
    `rental_date` TIMESTAMP NOT NULL,
    `inventory_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `return_date` TIMESTAMP DEFAULT NULL,
    `staff_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`rental_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `sakila_1`.`customer` (`customer_id`),
    FOREIGN KEY (`inventory_id`) REFERENCES `sakila_1`.`inventory` (`inventory_id`),
    FOREIGN KEY (`staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`)
);

DROP TABLE IF EXISTS `sakila_1`.`payment`;
CREATE TABLE `sakila_1`.`payment` (
    `payment_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `staff_id` SMALLINT NOT NULL,
    `rental_id` INT DEFAULT NULL,
    `amount` DECIMAL(5,2) NOT NULL,
    `payment_date` TIMESTAMP NOT NULL,
    `last_update` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`payment_id`),
    FOREIGN KEY (`staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`),
    FOREIGN KEY (`customer_id`) REFERENCES `sakila_1`.`customer` (`customer_id`),
    FOREIGN KEY (`rental_id`) REFERENCES `sakila_1`.`rental` (`rental_id`)
);
