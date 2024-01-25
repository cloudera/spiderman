drop table if exists `mountain_photos`.`mountain`;
CREATE TABLE IF NOT EXISTS `mountain_photos`.`mountain` (
    `id` INT,
    `name` STRING,
    `Height` REAL,
    `Prominence` REAL,
    `Range` STRING,
    `Country` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/mountain_photos/data/mountain.csv' INTO TABLE `mountain_photos`.`mountain`;


drop table if exists `mountain_photos`.`camera_lens`;
CREATE TABLE IF NOT EXISTS `mountain_photos`.`camera_lens` (
    `id` INT,
    `brand` STRING,
    `name` STRING,
    `focal_length_mm` REAL,
    `max_aperture` REAL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/mountain_photos/data/camera_lens.csv' INTO TABLE `mountain_photos`.`camera_lens`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/mountain_photos/data/photos.csv' INTO TABLE `mountain_photos`.`photos`;

