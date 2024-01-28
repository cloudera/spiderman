CREATE DATABASE IF NOT EXISTS `flight_company`;

drop table if exists `flight_company`.`airport`;
CREATE TABLE IF NOT EXISTS `flight_company`.`airport` (
    `id` INT,
    `City` STRING,
    `Country` STRING,
    `IATA` STRING,
    `ICAO` STRING,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `flight_company`.`operate_company`;
CREATE TABLE IF NOT EXISTS `flight_company`.`operate_company` (
    `id` INT,
    `name` STRING,
    `Type` STRING,
    `Principal_activities` STRING,
    `Incorporated_in` STRING,
    `Group_Equity_Shareholding` DOUBLE,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
);

drop table if exists `flight_company`.`flight`;
CREATE TABLE IF NOT EXISTS `flight_company`.`flight` (
    `id` INT,
    `Vehicle_Flight_number` STRING,
    `Date` STRING,
    `Pilot` STRING,
    `Velocity` DOUBLE,
    `Altitude` DOUBLE,
    `airport_id` INT,
    `company_id` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`company_id`) REFERENCES `flight_company`.`operate_company` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`airport_id`) REFERENCES `flight_company`.`airport` (`id`) DISABLE NOVALIDATE
);
