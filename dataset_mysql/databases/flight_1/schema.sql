-- Dialect: MySQL | Database: flight_1 | Table Count: 4

CREATE DATABASE IF NOT EXISTS `flight_1`;

DROP TABLE IF EXISTS `flight_1`.`aircraft`;
CREATE TABLE `flight_1`.`aircraft` (
    `aid` NUMERIC(9,0),
    `name` VARCHAR(30),
    `distance` NUMERIC(6,0),
    PRIMARY KEY (`aid`)
);

DROP TABLE IF EXISTS `flight_1`.`flight`;
CREATE TABLE `flight_1`.`flight` (
    `flno` NUMERIC(4,0),
    `origin` VARCHAR(20),
    `destination` VARCHAR(20),
    `distance` NUMERIC(6,0),
    `departure_date` DATE,
    `arrival_date` DATE,
    `price` NUMERIC(7,2),
    `aid` NUMERIC(9,0),
    PRIMARY KEY (`flno`),
    FOREIGN KEY (`aid`) REFERENCES `flight_1`.`aircraft` (`aid`)
);

DROP TABLE IF EXISTS `flight_1`.`employee`;
CREATE TABLE `flight_1`.`employee` (
    `eid` NUMERIC(9,0),
    `name` VARCHAR(30),
    `salary` NUMERIC(10,2),
    PRIMARY KEY (`eid`)
);

DROP TABLE IF EXISTS `flight_1`.`certificate`;
CREATE TABLE `flight_1`.`certificate` (
    `eid` NUMERIC(9,0),
    `aid` NUMERIC(9,0),
    PRIMARY KEY (`eid`, `aid`),
    FOREIGN KEY (`aid`) REFERENCES `flight_1`.`aircraft` (`aid`),
    FOREIGN KEY (`eid`) REFERENCES `flight_1`.`employee` (`eid`)
);
