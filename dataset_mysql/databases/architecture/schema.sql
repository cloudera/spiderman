-- Dialect: mysql | Database: architecture | Table Count: 3

CREATE TABLE `architecture`.`architect` (
    `id` INT,
    `name` TEXT,
    `nationality` TEXT,
    `gender` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `architecture`.`bridge` (
    `architect_id` INT,
    `id` INT,
    `name` TEXT,
    `location` TEXT,
    `length_meters` REAL,
    `length_feet` REAL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`architect_id`) REFERENCES `architecture`.`architect` (`id`)
);

CREATE TABLE `architecture`.`mill` (
    `architect_id` INT,
    `id` INT,
    `location` TEXT,
    `name` TEXT,
    `type` TEXT,
    `built_year` INT,
    `notes` TEXT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`architect_id`) REFERENCES `architecture`.`architect` (`id`)
);
