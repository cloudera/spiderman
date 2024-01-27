drop table if exists `flight_2`.`airlines`;
CREATE TABLE IF NOT EXISTS `flight_2`.`airlines` (
    `uid` INT,
    `Airline` STRING,
    `Abbreviation` STRING,
    `Country` STRING,
    PRIMARY KEY (`uid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_2/data/airlines.csv' INTO TABLE `flight_2`.`airlines`;


drop table if exists `flight_2`.`airports`;
CREATE TABLE IF NOT EXISTS `flight_2`.`airports` (
    `City` STRING,
    `AirportCode` STRING,
    `AirportName` STRING,
    `Country` STRING,
    `CountryAbbrev` STRING,
    PRIMARY KEY (`AirportCode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_2/data/airports.csv' INTO TABLE `flight_2`.`airports`;


drop table if exists `flight_2`.`flights`;
CREATE TABLE IF NOT EXISTS `flight_2`.`flights` (
    `Airline` INT,
    `FlightNo` INT,
    `SourceAirport` STRING,
    `DestAirport` STRING,
    PRIMARY KEY (`Airline`, `FlightNo`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DestAirport`) REFERENCES `flight_2`.`airports` (`AirportCode`) DISABLE NOVALIDATE,
    FOREIGN KEY (`SourceAirport`) REFERENCES `flight_2`.`airports` (`AirportCode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_2/data/flights.csv' INTO TABLE `flight_2`.`flights`;
