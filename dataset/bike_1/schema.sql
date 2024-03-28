-- Dialect: MySQL | Database: bike_1 | Table Count: 4

CREATE DATABASE IF NOT EXISTS `bike_1`;

DROP TABLE IF EXISTS `bike_1`.`station`;
CREATE TABLE `bike_1`.`station` (
    `id` INTEGER,
    `name` TEXT,
    `lat` NUMERIC,
    `long` NUMERIC,
    `dock_count` INTEGER,
    `city` TEXT,
    `installation_date` TEXT,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `bike_1`.`status`;
CREATE TABLE `bike_1`.`status` (
    `station_id` INTEGER,
    `bikes_available` INTEGER,
    `docks_available` INTEGER,
    `time` TEXT,
    FOREIGN KEY (`station_id`) REFERENCES `bike_1`.`station` (`id`)
);

DROP TABLE IF EXISTS `bike_1`.`trip`;
CREATE TABLE `bike_1`.`trip` (
    `id` INTEGER,
    `duration` INTEGER,
    `start_date` TEXT,
    `start_station_name` TEXT,
    `start_station_id` INTEGER,
    `end_date` TEXT,
    `end_station_name` TEXT,
    `end_station_id` INTEGER,
    `bike_id` INTEGER,
    `subscription_type` TEXT,
    `zip_code` INTEGER,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `bike_1`.`weather`;
CREATE TABLE `bike_1`.`weather` (
    `date` TEXT,
    `max_temperature_f` INTEGER,
    `mean_temperature_f` INTEGER,
    `min_temperature_f` INTEGER,
    `max_dew_point_f` INTEGER,
    `mean_dew_point_f` INTEGER,
    `min_dew_point_f` INTEGER,
    `max_humidity` INTEGER,
    `mean_humidity` INTEGER,
    `min_humidity` INTEGER,
    `max_sea_level_pressure_inches` NUMERIC,
    `mean_sea_level_pressure_inches` NUMERIC,
    `min_sea_level_pressure_inches` NUMERIC,
    `max_visibility_miles` INTEGER,
    `mean_visibility_miles` INTEGER,
    `min_visibility_miles` INTEGER,
    `max_wind_Speed_mph` INTEGER,
    `mean_wind_speed_mph` INTEGER,
    `max_gust_speed_mph` INTEGER,
    `precipitation_inches` INTEGER,
    `cloud_cover` INTEGER,
    `events` TEXT,
    `wind_dir_degrees` INTEGER,
    `zip_code` INTEGER
);
