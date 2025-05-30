-- Dialect: mysql | Database: medicine_enzyme_interaction | Table Count: 3

CREATE TABLE `medicine_enzyme_interaction`.`medicine` (
    `id` INT,
    `name` TEXT,
    `Trade_Name` TEXT,
    `FDA_approved` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `medicine_enzyme_interaction`.`enzyme` (
    `id` INT,
    `name` TEXT,
    `Location` TEXT,
    `Product` TEXT,
    `Chromosome` TEXT,
    `OMIM` INT,
    `Porphyria` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `medicine_enzyme_interaction`.`medicine_enzyme_interaction` (
    `enzyme_id` INT,
    `medicine_id` INT,
    `interaction_type` TEXT,
    PRIMARY KEY (`enzyme_id`, `medicine_id`),
    FOREIGN KEY (`medicine_id`) REFERENCES `medicine_enzyme_interaction`.`medicine` (`id`),
    FOREIGN KEY (`enzyme_id`) REFERENCES `medicine_enzyme_interaction`.`enzyme` (`id`)
);
