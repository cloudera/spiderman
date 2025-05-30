-- Dialect: mysql | Database: flight_2 | Table Count: 3

CREATE TABLE `flight_2`.`airlines` (
    `uid` INTEGER,
    `Airline` TEXT,
    `Abbreviation` TEXT,
    `Country` TEXT,
    PRIMARY KEY (`uid`)
);

CREATE TABLE `flight_2`.`airports` (
    `City` TEXT,
    `AirportCode` VARCHAR(50),
    `AirportName` TEXT,
    `Country` TEXT,
    `CountryAbbrev` TEXT,
    PRIMARY KEY (`AirportCode`)
);

CREATE TABLE `flight_2`.`flights` (
    `Airline` INTEGER,
    `FlightNo` INTEGER,
    `SourceAirport` VARCHAR(50),
    `DestAirport` VARCHAR(50),
    PRIMARY KEY (`Airline`, `FlightNo`),
    FOREIGN KEY (`DestAirport`) REFERENCES `flight_2`.`airports` (`AirportCode`),
    FOREIGN KEY (`SourceAirport`) REFERENCES `flight_2`.`airports` (`AirportCode`)
);
