-- Dialect: mysql | Database: flight_4 | Table Count: 3

CREATE TABLE `flight_4`.`airlines` (
    `alid` INTEGER,
    `name` TEXT,
    `iata` VARCHAR(2),
    `icao` VARCHAR(3),
    `callsign` TEXT,
    `country` TEXT,
    `active` VARCHAR(2),
    PRIMARY KEY (`alid`)
);

CREATE TABLE `flight_4`.`airports` (
    `apid` INTEGER,
    `name` TEXT NOT NULL,
    `city` TEXT,
    `country` TEXT,
    `x` REAL,
    `y` REAL,
    `elevation` BIGINT,
    `iata` VARCHAR(3),
    `icao` VARCHAR(4),
    PRIMARY KEY (`apid`)
);

CREATE TABLE `flight_4`.`routes` (
    `rid` INTEGER,
    `dst_apid` INTEGER,
    `dst_ap` VARCHAR(4),
    `src_apid` INT,
    `src_ap` VARCHAR(4),
    `alid` INT,
    `airline` VARCHAR(4),
    `codeshare` TEXT,
    PRIMARY KEY (`rid`),
    FOREIGN KEY (`alid`) REFERENCES `flight_4`.`airlines` (`alid`),
    FOREIGN KEY (`src_apid`) REFERENCES `flight_4`.`airports` (`apid`),
    FOREIGN KEY (`dst_apid`) REFERENCES `flight_4`.`airports` (`apid`)
);
