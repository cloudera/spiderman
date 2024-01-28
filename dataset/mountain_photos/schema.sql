CREATE DATABASE IF NOT EXISTS `mountain_photos`;

drop table if exists `mountain_photos`.`mountain`;
CREATE TABLE IF NOT EXISTS `mountain_photos`.`mountain` (
    `id` INT,
    `name` STRING,
    `Height` DOUBLE,
    `Prominence` DOUBLE,
    `Range` STRING,
    `Country` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `mountain_photos`.`camera_lens`;
CREATE TABLE IF NOT EXISTS `mountain_photos`.`camera_lens` (
    `id` INT,
    `brand` STRING,
    `name` STRING,
    `focal_length_mm` DOUBLE,
    `max_aperture` DOUBLE,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `mountain_photos`.`photos`;
CREATE TABLE IF NOT EXISTS `mountain_photos`.`photos` (
    `id` INT,
    `camera_lens_id` INT,
    `mountain_id` INT,
    `color` STRING,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`mountain_id`) REFERENCES `mountain_photos`.`mountain` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`camera_lens_id`) REFERENCES `mountain_photos`.`camera_lens` (`id`) DISABLE NOVALIDATE
);
