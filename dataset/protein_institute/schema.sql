-- Dialect: MySQL | Database: protein_institute | Table Count: 3

CREATE DATABASE IF NOT EXISTS `protein_institute`;

DROP TABLE IF EXISTS `protein_institute`.`building`;
CREATE TABLE `protein_institute`.`building` (
    `building_id` INT,
    `Name` TEXT,
    `Street_address` TEXT,
    `Years_as_tallest` TEXT,
    `Height_feet` INT,
    `Floors` INT,
    PRIMARY KEY (`building_id`)
);

DROP TABLE IF EXISTS `protein_institute`.`Institution`;
CREATE TABLE `protein_institute`.`Institution` (
    `Institution_id` INT,
    `Institution` TEXT,
    `Location` TEXT,
    `Founded` REAL,
    `Type` TEXT,
    `Enrollment` INT,
    `Team` TEXT,
    `Primary_Conference` TEXT,
    `building_id` INT,
    PRIMARY KEY (`Institution_id`),
    FOREIGN KEY (`building_id`) REFERENCES `protein_institute`.`building` (`building_id`)
);

DROP TABLE IF EXISTS `protein_institute`.`protein`;
CREATE TABLE `protein_institute`.`protein` (
    `common_name` VARCHAR(50),
    `protein_name` TEXT,
    `divergence_from_human_lineage` REAL,
    `accession_number` TEXT,
    `sequence_length` REAL,
    `sequence_identity_to_human_protein` TEXT,
    `Institution_id` INT,
    PRIMARY KEY (`common_name`),
    FOREIGN KEY (`Institution_id`) REFERENCES `protein_institute`.`Institution` (`Institution_id`)
);
