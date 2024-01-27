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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tvshow/data/TV_Channel.csv' INTO TABLE `tvshow`.`TV_Channel`;


drop table if exists `tvshow`.`TV_series`;
CREATE TABLE IF NOT EXISTS `tvshow`.`TV_series` (
    `id` REAL,
    `Episode` STRING,
    `Air_Date` STRING,
    `Rating` STRING,
    `Share` REAL,
    `18_49_Rating_Share` STRING,
    `Viewers_m` STRING,
    `Weekly_Rank` REAL,
    `Channel` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel`) REFERENCES `tvshow`.`TV_Channel` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tvshow/data/TV_series.csv' INTO TABLE `tvshow`.`TV_series`;


drop table if exists `tvshow`.`Cartoon`;
CREATE TABLE IF NOT EXISTS `tvshow`.`Cartoon` (
    `id` REAL,
    `Title` STRING,
    `Directed_by` STRING,
    `Written_by` STRING,
    `Original_air_date` STRING,
    `Production_code` REAL,
    `Channel` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel`) REFERENCES `tvshow`.`TV_Channel` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tvshow/data/Cartoon.csv' INTO TABLE `tvshow`.`Cartoon`;

