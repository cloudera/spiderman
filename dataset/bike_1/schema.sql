CREATE DATABASE IF NOT EXISTS `bike_1`;

drop table if exists `bike_1`.`station`;
CREATE TABLE IF NOT EXISTS `bike_1`.`station` (
    `id` INT,
    `name` STRING,
    `lat` NUMERIC,
    `long` NUMERIC,
    `dock_count` INT,
    `city` STRING,
    `installation_date` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `bike_1`.`status`;
CREATE TABLE IF NOT EXISTS `bike_1`.`status` (
    `station_id` INT,
    `bikes_available` INT,
    `docks_available` INT,
    `time` STRING,
    FOREIGN KEY (`station_id`) REFERENCES `bike_1`.`station` (`id`) DISABLE NOVALIDATE
);

drop table if exists `bike_1`.`trip`;
CREATE TABLE IF NOT EXISTS `bike_1`.`trip` (
    `id` INT,
    `duration` INT,
    `start_date` STRING,
    `start_station_name` STRING,
    `start_station_id` INT,
    `end_date` STRING,
    `end_station_name` STRING,
    `end_station_id` INT,
    `bike_id` INT,
    `subscription_type` STRING,
    `zip_code` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `bike_1`.`weather`;
CREATE TABLE IF NOT EXISTS `bike_1`.`weather` (
    `date` STRING,
    `max_temperature_f` INT,
    `mean_temperature_f` INT,
    `min_temperature_f` INT,
    `max_dew_point_f` INT,
    `mean_dew_point_f` INT,
    `min_dew_point_f` INT,
    `max_humidity` INT,
    `mean_humidity` INT,
    `min_humidity` INT,
    `max_sea_level_pressure_inches` NUMERIC,
    `mean_sea_level_pressure_inches` NUMERIC,
    `min_sea_level_pressure_inches` NUMERIC,
    `max_visibility_miles` INT,
    `mean_visibility_miles` INT,
    `min_visibility_miles` INT,
    `max_wind_Speed_mph` INT,
    `mean_wind_speed_mph` INT,
    `max_gust_speed_mph` INT,
    `precipitation_inches` INT,
    `cloud_cover` INT,
    `events` STRING,
    `wind_dir_degrees` INT,
    `zip_code` INT
);
