CREATE DATABASE IF NOT EXISTS `formula_1`;

drop table if exists `formula_1`.`circuits`;
CREATE TABLE IF NOT EXISTS `formula_1`.`circuits` (
    `circuitId` INT,
    `circuitRef` STRING,
    `name` STRING,
    `location` STRING,
    `country` STRING,
    `lat` DOUBLE,
    `lng` DOUBLE,
    `alt` STRING,
    `url` STRING,
    PRIMARY KEY (`circuitId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`races`;
CREATE TABLE IF NOT EXISTS `formula_1`.`races` (
    `raceId` INT,
    `year` INT,
    `round` INT,
    `circuitId` INT,
    `name` STRING,
    `date` STRING,
    `time` STRING,
    `url` STRING,
    PRIMARY KEY (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`circuitId`) REFERENCES `formula_1`.`circuits` (`circuitId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`drivers`;
CREATE TABLE IF NOT EXISTS `formula_1`.`drivers` (
    `driverId` INT,
    `driverRef` STRING,
    `number` STRING,
    `code` STRING,
    `forename` STRING,
    `surname` STRING,
    `dob` STRING,
    `nationality` STRING,
    `url` STRING,
    PRIMARY KEY (`driverId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`status`;
CREATE TABLE IF NOT EXISTS `formula_1`.`status` (
    `statusId` INT,
    `status` STRING,
    PRIMARY KEY (`statusId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`seasons`;
CREATE TABLE IF NOT EXISTS `formula_1`.`seasons` (
    `year` INT,
    `url` STRING,
    PRIMARY KEY (`year`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`constructors`;
CREATE TABLE IF NOT EXISTS `formula_1`.`constructors` (
    `constructorId` INT,
    `constructorRef` STRING,
    `name` STRING,
    `nationality` STRING,
    `url` STRING,
    PRIMARY KEY (`constructorId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`constructorStandings`;
CREATE TABLE IF NOT EXISTS `formula_1`.`constructorStandings` (
    `constructorStandingsId` INT,
    `raceId` INT,
    `constructorId` INT,
    `points` DOUBLE,
    `position` INT,
    `positionText` STRING,
    `wins` INT,
    PRIMARY KEY (`constructorStandingsId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`results`;
CREATE TABLE IF NOT EXISTS `formula_1`.`results` (
    `resultId` INT,
    `raceId` INT,
    `driverId` INT,
    `constructorId` INT,
    `number` INT,
    `grid` INT,
    `position` STRING,
    `positionText` STRING,
    `positionOrder` INT,
    `points` DOUBLE,
    `laps` STRING,
    `time` STRING,
    `milliseconds` STRING,
    `fastestLap` STRING,
    `rank` STRING,
    `fastestLapTime` STRING,
    `fastestLapSpeed` STRING,
    `statusId` INT,
    PRIMARY KEY (`resultId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`driverStandings`;
CREATE TABLE IF NOT EXISTS `formula_1`.`driverStandings` (
    `driverStandingsId` INT,
    `raceId` INT,
    `driverId` INT,
    `points` DOUBLE,
    `position` INT,
    `positionText` STRING,
    `wins` INT,
    PRIMARY KEY (`driverStandingsId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`constructorResults`;
CREATE TABLE IF NOT EXISTS `formula_1`.`constructorResults` (
    `constructorResultsId` INT,
    `raceId` INT,
    `constructorId` INT,
    `points` DOUBLE,
    `status` STRING,
    PRIMARY KEY (`constructorResultsId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`) DISABLE NOVALIDATE
);

drop table if exists `formula_1`.`qualifying`;
CREATE TABLE IF NOT EXISTS `formula_1`.`qualifying` (
    `qualifyId` INT,
    `raceId` INT,
    `driverId` INT,
    `constructorId` INT,
    `number` INT,
    `position` INT,
    `q1` STRING,
    `q2` STRING,
    `q3` STRING,
    PRIMARY KEY (`qualifyId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`) DISABLE NOVALIDATE
);
