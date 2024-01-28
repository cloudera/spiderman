CREATE DATABASE IF NOT EXISTS `medicine_enzyme_interaction`;

drop table if exists `medicine_enzyme_interaction`.`medicine`;
CREATE TABLE IF NOT EXISTS `medicine_enzyme_interaction`.`medicine` (
    `id` INT,
    `name` STRING,
    `Trade_Name` STRING,
    `FDA_approved` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `medicine_enzyme_interaction`.`enzyme`;
CREATE TABLE IF NOT EXISTS `medicine_enzyme_interaction`.`enzyme` (
    `id` INT,
    `name` STRING,
    `Location` STRING,
    `Product` STRING,
    `Chromosome` STRING,
    `OMIM` INT,
    `Porphyria` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `medicine_enzyme_interaction`.`medicine_enzyme_interaction`;
CREATE TABLE IF NOT EXISTS `medicine_enzyme_interaction`.`medicine_enzyme_interaction` (
    `enzyme_id` INT,
    `medicine_id` INT,
    `interaction_type` STRING,
    PRIMARY KEY (`enzyme_id`, `medicine_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`medicine_id`) REFERENCES `medicine_enzyme_interaction`.`medicine` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`enzyme_id`) REFERENCES `medicine_enzyme_interaction`.`enzyme` (`id`) DISABLE NOVALIDATE
);
