drop table if exists `sakila_1`.`actor`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`actor` (
    `actor_id` INT NOT NULL,
    `first_name` STRING NOT NULL,
    `last_name` STRING NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`actor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/actor.csv' INTO TABLE `sakila_1`.`actor`;


drop table if exists `sakila_1`.`country`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`country` (
    `country_id` INT NOT NULL,
    `country` STRING NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`country_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/country.csv' INTO TABLE `sakila_1`.`country`;


drop table if exists `sakila_1`.`city`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`city` (
    `city_id` INT NOT NULL,
    `city` STRING NOT NULL,
    `country_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`city_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`country_id`) REFERENCES `sakila_1`.`country` (`country_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/city.csv' INTO TABLE `sakila_1`.`city`;


drop table if exists `sakila_1`.`address`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`address` (
    `address_id` INT NOT NULL,
    `address` STRING NOT NULL,
    `address2` STRING,
    `district` STRING NOT NULL,
    `city_id` INT NOT NULL,
    `postal_code` STRING,
    `phone` STRING NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`city_id`) REFERENCES `sakila_1`.`city` (`city_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/address.csv' INTO TABLE `sakila_1`.`address`;


drop table if exists `sakila_1`.`category`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`category` (
    `category_id` SMALLINT NOT NULL,
    `name` STRING NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`category_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/category.csv' INTO TABLE `sakila_1`.`category`;


drop table if exists `sakila_1`.`staff`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`staff` (
    `staff_id` SMALLINT NOT NULL,
    `first_name` STRING NOT NULL,
    `last_name` STRING NOT NULL,
    `address_id` INT NOT NULL,
    `picture` BINARY,
    `email` STRING,
    `store_id` SMALLINT NOT NULL,
    `active` BOOLEAN NOT NULL,
    `username` STRING NOT NULL,
    `password` STRING,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/staff.csv' INTO TABLE `sakila_1`.`staff`;


drop table if exists `sakila_1`.`store`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`store` (
    `store_id` SMALLINT NOT NULL,
    `manager_staff_id` SMALLINT NOT NULL,
    `address_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`store_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`manager_staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/store.csv' INTO TABLE `sakila_1`.`store`;


drop table if exists `sakila_1`.`customer`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`customer` (
    `customer_id` INT NOT NULL,
    `store_id` SMALLINT NOT NULL,
    `first_name` STRING NOT NULL,
    `last_name` STRING NOT NULL,
    `email` STRING,
    `address_id` INT NOT NULL,
    `active` BOOLEAN NOT NULL,
    `create_date` TIMESTAMP NOT NULL,
    `last_update` TIMESTAMP,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`store_id`) REFERENCES `sakila_1`.`store` (`store_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/customer.csv' INTO TABLE `sakila_1`.`customer`;


drop table if exists `sakila_1`.`language`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`language` (
    `language_id` SMALLINT NOT NULL,
    `name` CHAR(20) NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`language_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/language.csv' INTO TABLE `sakila_1`.`language`;


drop table if exists `sakila_1`.`film`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`film` (
    `film_id` INT NOT NULL,
    `title` STRING NOT NULL,
    `description` STRING,
    `release_year` INT,
    `language_id` SMALLINT NOT NULL,
    `original_language_id` SMALLINT,
    `rental_duration` SMALLINT NOT NULL,
    `rental_rate` DECIMAL(4,2) NOT NULL,
    `length` INT,
    `replacement_cost` DECIMAL(5,2) NOT NULL,
    `rating` STRING,
    `special_features` STRING,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`film_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`original_language_id`) REFERENCES `sakila_1`.`language` (`language_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`language_id`) REFERENCES `sakila_1`.`language` (`language_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/film.csv' INTO TABLE `sakila_1`.`film`;


drop table if exists `sakila_1`.`film_actor`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`film_actor` (
    `actor_id` INT NOT NULL,
    `film_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`actor_id`, `film_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`actor_id`) REFERENCES `sakila_1`.`actor` (`actor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/film_actor.csv' INTO TABLE `sakila_1`.`film_actor`;


drop table if exists `sakila_1`.`film_category`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`film_category` (
    `film_id` INT NOT NULL,
    `category_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`film_id`, `category_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`category_id`) REFERENCES `sakila_1`.`category` (`category_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/film_category.csv' INTO TABLE `sakila_1`.`film_category`;


drop table if exists `sakila_1`.`film_text`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`film_text` (
    `film_id` SMALLINT NOT NULL,
    `title` STRING NOT NULL,
    `description` STRING,
    PRIMARY KEY (`film_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/film_text.csv' INTO TABLE `sakila_1`.`film_text`;


drop table if exists `sakila_1`.`inventory`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`inventory` (
    `inventory_id` INT NOT NULL,
    `film_id` INT NOT NULL,
    `store_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`inventory_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`store_id`) REFERENCES `sakila_1`.`store` (`store_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/inventory.csv' INTO TABLE `sakila_1`.`inventory`;


drop table if exists `sakila_1`.`rental`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`rental` (
    `rental_id` INT NOT NULL,
    `rental_date` TIMESTAMP NOT NULL,
    `inventory_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `return_date` TIMESTAMP,
    `staff_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`rental_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `sakila_1`.`customer` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`inventory_id`) REFERENCES `sakila_1`.`inventory` (`inventory_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/rental.csv' INTO TABLE `sakila_1`.`rental`;


drop table if exists `sakila_1`.`payment`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`payment` (
    `payment_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `staff_id` SMALLINT NOT NULL,
    `rental_id` INT,
    `amount` DECIMAL(5,2) NOT NULL,
    `payment_date` TIMESTAMP NOT NULL,
    `last_update` TIMESTAMP,
    PRIMARY KEY (`payment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `sakila_1`.`customer` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`rental_id`) REFERENCES `sakila_1`.`rental` (`rental_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/payment.csv' INTO TABLE `sakila_1`.`payment`;

