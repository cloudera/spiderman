CREATE DATABASE IF NOT EXISTS `flight_4`;

drop table if exists `flight_4`.`airlines`;
CREATE TABLE IF NOT EXISTS `flight_4`.`airlines` (
    `alid` INT,
    `name` STRING,
    `iata` STRING,
    `icao` STRING,
    `callsign` STRING,
    `country` STRING,
    `active` STRING,
    PRIMARY KEY (`alid`) DISABLE NOVALIDATE
);

drop table if exists `flight_4`.`airports`;
CREATE TABLE IF NOT EXISTS `flight_4`.`airports` (
    `apid` INT,
    `name` STRING NOT NULL,
    `city` STRING,
    `country` STRING,
    `x` DOUBLE,
    `y` DOUBLE,
    `elevation` BIGINT,
    `iata` STRING,
    `icao` STRING,
    PRIMARY KEY (`apid`) DISABLE NOVALIDATE
);

drop table if exists `flight_4`.`routes`;
CREATE TABLE IF NOT EXISTS `flight_4`.`routes` (
    `rid` INT,
    `dst_apid` INT,
    `dst_ap` STRING,
    `src_apid` INT,
    `src_ap` STRING,
    `alid` INT,
    `airline` STRING,
    `codeshare` STRING,
    PRIMARY KEY (`rid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`alid`) REFERENCES `flight_4`.`airlines` (`alid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`src_apid`) REFERENCES `flight_4`.`airports` (`apid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dst_apid`) REFERENCES `flight_4`.`airports` (`apid`) DISABLE NOVALIDATE
);
