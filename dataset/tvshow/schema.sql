CREATE DATABASE IF NOT EXISTS `tvshow`;

drop table if exists `tvshow`.`TV_Channel`;
CREATE TABLE IF NOT EXISTS `tvshow`.`TV_Channel` (
    `id` STRING,
    `series_name` STRING,
    `Country` STRING,
    `Language` STRING,
    `Content` STRING,
    `Pixel_aspect_ratio_PAR` STRING,
    `Hight_definition_TV` STRING,
    `Pay_per_view_PPV` STRING,
    `Package_Option` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `tvshow`.`TV_series`;
CREATE TABLE IF NOT EXISTS `tvshow`.`TV_series` (
    `id` DOUBLE,
    `Episode` STRING,
    `Air_Date` STRING,
    `Rating` STRING,
    `Share` DOUBLE,
    `18_49_Rating_Share` STRING,
    `Viewers_m` STRING,
    `Weekly_Rank` DOUBLE,
    `Channel` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel`) REFERENCES `tvshow`.`TV_Channel` (`id`) DISABLE NOVALIDATE
);

drop table if exists `tvshow`.`Cartoon`;
CREATE TABLE IF NOT EXISTS `tvshow`.`Cartoon` (
    `id` DOUBLE,
    `Title` STRING,
    `Directed_by` STRING,
    `Written_by` STRING,
    `Original_air_date` STRING,
    `Production_code` DOUBLE,
    `Channel` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel`) REFERENCES `tvshow`.`TV_Channel` (`id`) DISABLE NOVALIDATE
);
