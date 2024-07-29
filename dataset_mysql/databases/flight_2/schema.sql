-- Dialect: MySQL | Database: flight_2 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `flight_2`;

DROP TABLE IF EXISTS `flight_2`.`airlines`;
CREATE TABLE `flight_2`.`airlines` (
    `uid` INTEGER,
    `Airline` TEXT,
    `Abbreviation` TEXT,
    `Country` TEXT,
    PRIMARY KEY (`uid`)
);

DROP TABLE IF EXISTS `flight_2`.`airports`;
CREATE TABLE `flight_2`.`airports` (
    `City` TEXT,
    `AirportCode` VARCHAR(50),
    `AirportName` TEXT,
    `Country` TEXT,
    `CountryAbbrev` TEXT,
    PRIMARY KEY (`AirportCode`)
);

DROP TABLE IF EXISTS `flight_2`.`flights`;
CREATE TABLE `flight_2`.`flights` (
    `Airline` INTEGER,
    `FlightNo` INTEGER,
    `SourceAirport` VARCHAR(50),
    `DestAirport` VARCHAR(50),
    PRIMARY KEY (`Airline`, `FlightNo`),
    FOREIGN KEY (`DestAirport`) REFERENCES `flight_2`.`airports` (`AirportCode`),
    FOREIGN KEY (`SourceAirport`) REFERENCES `flight_2`.`airports` (`AirportCode`)
);
