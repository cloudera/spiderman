drop table if exists `station_weather`.`train`;
CREATE TABLE IF NOT EXISTS `station_weather`.`train` (
    `id` INT,
    `train_number` INT,
    `name` STRING,
    `origin` STRING,
    `destination` STRING,
    `time` STRING,
    `interval` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/station_weather/data/train.csv' INTO TABLE `station_weather`.`train`;


drop table if exists `station_weather`.`station`;
CREATE TABLE IF NOT EXISTS `station_weather`.`station` (
    `id` INT,
    `network_name` STRING,
    `services` STRING,
    `local_authority` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/station_weather/data/station.csv' INTO TABLE `station_weather`.`station`;


drop table if exists `station_weather`.`route`;
CREATE TABLE IF NOT EXISTS `station_weather`.`route` (
    `train_id` INT,
    `station_id` INT,
    PRIMARY KEY (`train_id`, `station_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`station_id`) REFERENCES `station_weather`.`station` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`train_id`) REFERENCES `station_weather`.`train` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/station_weather/data/route.csv' INTO TABLE `station_weather`.`route`;


drop table if exists `station_weather`.`weekly_weather`;
CREATE TABLE IF NOT EXISTS `station_weather`.`weekly_weather` (
    `station_id` INT,
    `day_of_week` STRING,
    `high_temperature` INT,
    `low_temperature` INT,
    `precipitation` REAL,
    `wind_speed_mph` INT,
    PRIMARY KEY (`station_id`, `day_of_week`) DISABLE NOVALIDATE,
    FOREIGN KEY (`station_id`) REFERENCES `station_weather`.`station` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/station_weather/data/weekly_weather.csv' INTO TABLE `station_weather`.`weekly_weather`;

