CREATE DATABASE IF NOT EXISTS `flight_1`;

drop table if exists `flight_1`.`aircraft`;
CREATE TABLE IF NOT EXISTS `flight_1`.`aircraft` (
    `aid` NUMERIC(9,0),
    `name` STRING,
    `distance` NUMERIC(6,0),
    PRIMARY KEY (`aid`) DISABLE NOVALIDATE
);

drop table if exists `flight_1`.`flight`;
CREATE TABLE IF NOT EXISTS `flight_1`.`flight` (
    `flno` NUMERIC(4,0),
    `origin` STRING,
    `destination` STRING,
    `distance` NUMERIC(6,0),
    `departure_date` DATE,
    `arrival_date` DATE,
    `price` NUMERIC(7,2),
    `aid` NUMERIC(9,0),
    PRIMARY KEY (`flno`) DISABLE NOVALIDATE,
    FOREIGN KEY (`aid`) REFERENCES `flight_1`.`aircraft` (`aid`) DISABLE NOVALIDATE
);

drop table if exists `flight_1`.`employee`;
CREATE TABLE IF NOT EXISTS `flight_1`.`employee` (
    `eid` NUMERIC(9,0),
    `name` STRING,
    `salary` NUMERIC(10,2),
    PRIMARY KEY (`eid`) DISABLE NOVALIDATE
);

drop table if exists `flight_1`.`certificate`;
CREATE TABLE IF NOT EXISTS `flight_1`.`certificate` (
    `eid` NUMERIC(9,0),
    `aid` NUMERIC(9,0),
    PRIMARY KEY (`eid`, `aid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`aid`) REFERENCES `flight_1`.`aircraft` (`aid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`eid`) REFERENCES `flight_1`.`employee` (`eid`) DISABLE NOVALIDATE
);
