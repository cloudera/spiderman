-- Dialect: mysql | Database: mountain_photos | Table Count: 3

CREATE TABLE `mountain_photos`.`mountain` (
    `id` INT,
    `name` TEXT,
    `Height` REAL,
    `Prominence` REAL,
    `Range` TEXT,
    `Country` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mountain_photos`.`camera_lens` (
    `id` INT,
    `brand` TEXT,
    `name` TEXT,
    `focal_length_mm` REAL,
    `max_aperture` REAL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `mountain_photos`.`photos` (
    `id` INT,
    `camera_lens_id` INT,
    `mountain_id` INT,
    `color` TEXT,
    `name` TEXT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`mountain_id`) REFERENCES `mountain_photos`.`mountain` (`id`),
    FOREIGN KEY (`camera_lens_id`) REFERENCES `mountain_photos`.`camera_lens` (`id`)
);
