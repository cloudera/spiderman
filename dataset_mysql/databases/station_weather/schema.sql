-- Dialect: mysql | Database: station_weather | Table Count: 4

CREATE TABLE `station_weather`.`train` (
    `id` INT,
    `train_number` INT,
    `name` TEXT,
    `origin` TEXT,
    `destination` TEXT,
    `time` TEXT,
    `interval` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `station_weather`.`station` (
    `id` INT,
    `network_name` TEXT,
    `services` TEXT,
    `local_authority` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `station_weather`.`route` (
    `train_id` INT,
    `station_id` INT,
    PRIMARY KEY (`train_id`, `station_id`),
    FOREIGN KEY (`station_id`) REFERENCES `station_weather`.`station` (`id`),
    FOREIGN KEY (`train_id`) REFERENCES `station_weather`.`train` (`id`)
);

CREATE TABLE `station_weather`.`weekly_weather` (
    `station_id` INT,
    `day_of_week` VARCHAR(20),
    `high_temperature` INT,
    `low_temperature` INT,
    `precipitation` REAL,
    `wind_speed_mph` INT,
    PRIMARY KEY (`station_id`, `day_of_week`),
    FOREIGN KEY (`station_id`) REFERENCES `station_weather`.`station` (`id`)
);
