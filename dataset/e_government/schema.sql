-- Dialect: MySQL | Database: e_government | Table Count: 10

CREATE DATABASE IF NOT EXISTS `e_government`;

DROP TABLE IF EXISTS `e_government`.`Addresses`;
CREATE TABLE `e_government`.`Addresses` (
    `address_id` INTEGER,
    `line_1_number_building` VARCHAR(80),
    `town_city` VARCHAR(50),
    `zip_postcode` VARCHAR(20),
    `state_province_county` VARCHAR(50),
    `country` VARCHAR(50),
    PRIMARY KEY (`address_id`)
);

DROP TABLE IF EXISTS `e_government`.`Services`;
CREATE TABLE `e_government`.`Services` (
    `service_id` INTEGER,
    `service_type_code` VARCHAR(15) NOT NULL,
    `service_name` VARCHAR(80),
    `service_descriptio` VARCHAR(255),
    PRIMARY KEY (`service_id`)
);

DROP TABLE IF EXISTS `e_government`.`Forms`;
CREATE TABLE `e_government`.`Forms` (
    `form_id` INTEGER,
    `form_type_code` VARCHAR(15) NOT NULL,
    `service_id` INTEGER,
    `form_number` VARCHAR(50),
    `form_name` VARCHAR(80),
    `form_description` VARCHAR(255),
    PRIMARY KEY (`form_id`),
    FOREIGN KEY (`service_id`) REFERENCES `e_government`.`Services` (`service_id`)
);

DROP TABLE IF EXISTS `e_government`.`Individuals`;
CREATE TABLE `e_government`.`Individuals` (
    `individual_id` INTEGER,
    `individual_first_name` VARCHAR(80),
    `individual_middle_name` VARCHAR(80),
    `inidividual_phone` VARCHAR(80),
    `individual_email` VARCHAR(80),
    `individual_address` VARCHAR(255),
    `individual_last_name` VARCHAR(80),
    PRIMARY KEY (`individual_id`)
);

DROP TABLE IF EXISTS `e_government`.`Organizations`;
CREATE TABLE `e_government`.`Organizations` (
    `organization_id` INTEGER,
    `date_formed` DATETIME,
    `organization_name` VARCHAR(255),
    `uk_vat_number` VARCHAR(20),
    PRIMARY KEY (`organization_id`)
);

DROP TABLE IF EXISTS `e_government`.`Parties`;
CREATE TABLE `e_government`.`Parties` (
    `party_id` INTEGER,
    `payment_method_code` VARCHAR(15) NOT NULL,
    `party_phone` VARCHAR(80),
    `party_email` VARCHAR(80),
    PRIMARY KEY (`party_id`)
);

DROP TABLE IF EXISTS `e_government`.`Organization_Contact_Individuals`;
CREATE TABLE `e_government`.`Organization_Contact_Individuals` (
    `individual_id` INTEGER NOT NULL,
    `organization_id` INTEGER NOT NULL,
    `date_contact_from` DATETIME NOT NULL,
    `date_contact_to` DATETIME,
    PRIMARY KEY (`individual_id`, `organization_id`),
    FOREIGN KEY (`individual_id`) REFERENCES `e_government`.`Individuals` (`individual_id`),
    FOREIGN KEY (`organization_id`) REFERENCES `e_government`.`Organizations` (`organization_id`)
);

DROP TABLE IF EXISTS `e_government`.`Party_Addresses`;
CREATE TABLE `e_government`.`Party_Addresses` (
    `party_id` INTEGER NOT NULL,
    `address_id` INTEGER NOT NULL,
    `date_address_from` DATETIME NOT NULL,
    `address_type_code` VARCHAR(15) NOT NULL,
    `date_address_to` DATETIME,
    PRIMARY KEY (`party_id`, `address_id`),
    FOREIGN KEY (`party_id`) REFERENCES `e_government`.`Parties` (`party_id`),
    FOREIGN KEY (`address_id`) REFERENCES `e_government`.`Addresses` (`address_id`)
);

DROP TABLE IF EXISTS `e_government`.`Party_Forms`;
CREATE TABLE `e_government`.`Party_Forms` (
    `party_id` INTEGER NOT NULL,
    `form_id` INTEGER NOT NULL,
    `date_completion_started` DATETIME NOT NULL,
    `form_status_code` VARCHAR(15) NOT NULL,
    `date_fully_completed` DATETIME,
    PRIMARY KEY (`party_id`, `form_id`),
    FOREIGN KEY (`form_id`) REFERENCES `e_government`.`Forms` (`form_id`),
    FOREIGN KEY (`party_id`) REFERENCES `e_government`.`Parties` (`party_id`)
);

DROP TABLE IF EXISTS `e_government`.`Party_Services`;
CREATE TABLE `e_government`.`Party_Services` (
    `booking_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `service_id` INTEGER NOT NULL,
    `service_datetime` DATETIME NOT NULL,
    `booking_made_date` DATETIME,
    FOREIGN KEY (`customer_id`) REFERENCES `e_government`.`Parties` (`party_id`),
    FOREIGN KEY (`service_id`) REFERENCES `e_government`.`Services` (`service_id`)
);
