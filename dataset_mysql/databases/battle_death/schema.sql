-- Dialect: mysql | Database: battle_death | Table Count: 3

CREATE TABLE `battle_death`.`battle` (
    `id` INT,
    `name` TEXT,
    `date` TEXT,
    `bulgarian_commander` TEXT,
    `latin_commander` TEXT,
    `result` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `battle_death`.`ship` (
    `lost_in_battle` INT,
    `id` INT,
    `name` TEXT,
    `tonnage` TEXT,
    `ship_type` TEXT,
    `location` TEXT,
    `disposition_of_ship` TEXT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`lost_in_battle`) REFERENCES `battle_death`.`battle` (`id`)
);

CREATE TABLE `battle_death`.`death` (
    `caused_by_ship_id` INT,
    `id` INT,
    `note` TEXT,
    `killed` INT,
    `injured` INT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`caused_by_ship_id`) REFERENCES `battle_death`.`ship` (`id`)
);
