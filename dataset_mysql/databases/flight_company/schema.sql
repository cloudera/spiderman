-- Dialect: MySQL | Database: flight_company | Table Count: 3

CREATE DATABASE IF NOT EXISTS `flight_company`;

DROP TABLE IF EXISTS `flight_company`.`airport`;
CREATE TABLE `flight_company`.`airport` (
    `id` INT,
    `City` TEXT,
    `Country` TEXT,
    `IATA` TEXT,
    `ICAO` TEXT,
    `name` TEXT,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `flight_company`.`operate_company`;
CREATE TABLE `flight_company`.`operate_company` (
    `id` INT,
    `name` TEXT,
    `Type` TEXT,
    `Principal_activities` TEXT,
    `Incorporated_in` TEXT,
    `Group_Equity_Shareholding` REAL,
    PRIMARY KEY (`id`)
);

DROP TABLE IF EXISTS `flight_company`.`flight`;
CREATE TABLE `flight_company`.`flight` (
    `id` INT,
    `Vehicle_Flight_number` TEXT,
    `Date` TEXT,
    `Pilot` TEXT,
    `Velocity` REAL,
    `Altitude` REAL,
    `airport_id` INT,
    `company_id` INT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`company_id`) REFERENCES `flight_company`.`operate_company` (`id`),
    FOREIGN KEY (`airport_id`) REFERENCES `flight_company`.`airport` (`id`)
);
