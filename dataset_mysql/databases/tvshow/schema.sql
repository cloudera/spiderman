-- Dialect: mysql | Database: tvshow | Table Count: 3

CREATE TABLE `tvshow`.`TV_Channel` (
    `id` INT,
    `series_name` TEXT,
    `Country` TEXT,
    `Language` TEXT,
    `Content` TEXT,
    `Pixel_aspect_ratio_PAR` TEXT,
    `Hight_definition_TV` TEXT,
    `Pay_per_view_PPV` TEXT,
    `Package_Option` TEXT,
    PRIMARY KEY (`id`)
);

CREATE TABLE `tvshow`.`TV_series` (
    `id` REAL,
    `Episode` TEXT,
    `Air_Date` TEXT,
    `Rating` TEXT,
    `Share` REAL,
    `18_49_Rating_Share` TEXT,
    `Viewers_m` TEXT,
    `Weekly_Rank` REAL,
    `Channel` INT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`Channel`) REFERENCES `tvshow`.`TV_Channel` (`id`)
);

CREATE TABLE `tvshow`.`Cartoon` (
    `id` REAL,
    `Title` TEXT,
    `Directed_by` TEXT,
    `Written_by` TEXT,
    `Original_air_date` TEXT,
    `Production_code` REAL,
    `Channel` INT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`Channel`) REFERENCES `tvshow`.`TV_Channel` (`id`)
);
