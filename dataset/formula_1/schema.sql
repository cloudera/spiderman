-- Dialect: MySQL | Database: formula_1 | Table Count: 13

CREATE DATABASE IF NOT EXISTS `formula_1`;

DROP TABLE IF EXISTS `formula_1`.`circuits`;
CREATE TABLE `formula_1`.`circuits` (
    `circuitId` INT,
    `circuitRef` TEXT,
    `name` TEXT,
    `location` TEXT,
    `country` TEXT,
    `lat` DOUBLE,
    `lng` DOUBLE,
    `alt` TEXT,
    `url` TEXT,
    PRIMARY KEY (`circuitId`)
);

DROP TABLE IF EXISTS `formula_1`.`races`;
CREATE TABLE `formula_1`.`races` (
    `raceId` INT,
    `year` INT,
    `round` INT,
    `circuitId` INT,
    `name` TEXT,
    `date` TEXT,
    `time` TEXT,
    `url` TEXT,
    PRIMARY KEY (`raceId`),
    FOREIGN KEY (`circuitId`) REFERENCES `formula_1`.`circuits` (`circuitId`)
);

DROP TABLE IF EXISTS `formula_1`.`drivers`;
CREATE TABLE `formula_1`.`drivers` (
    `driverId` INT,
    `driverRef` TEXT,
    `number` TEXT,
    `code` TEXT,
    `forename` TEXT,
    `surname` TEXT,
    `dob` TEXT,
    `nationality` TEXT,
    `url` TEXT,
    PRIMARY KEY (`driverId`)
);

DROP TABLE IF EXISTS `formula_1`.`status`;
CREATE TABLE `formula_1`.`status` (
    `statusId` INT,
    `status` TEXT,
    PRIMARY KEY (`statusId`)
);

DROP TABLE IF EXISTS `formula_1`.`seasons`;
CREATE TABLE `formula_1`.`seasons` (
    `year` INT,
    `url` TEXT,
    PRIMARY KEY (`year`)
);

DROP TABLE IF EXISTS `formula_1`.`constructors`;
CREATE TABLE `formula_1`.`constructors` (
    `constructorId` INT,
    `constructorRef` TEXT,
    `name` TEXT,
    `nationality` TEXT,
    `url` TEXT,
    PRIMARY KEY (`constructorId`)
);

DROP TABLE IF EXISTS `formula_1`.`constructorStandings`;
CREATE TABLE `formula_1`.`constructorStandings` (
    `constructorStandingsId` INT,
    `raceId` INT,
    `constructorId` INT,
    `points` DOUBLE,
    `position` INT,
    `positionText` TEXT,
    `wins` INT,
    PRIMARY KEY (`constructorStandingsId`),
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`),
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`)
);

DROP TABLE IF EXISTS `formula_1`.`results`;
CREATE TABLE `formula_1`.`results` (
    `resultId` INT,
    `raceId` INT,
    `driverId` INT,
    `constructorId` INT,
    `number` INT,
    `grid` INT,
    `position` TEXT,
    `positionText` TEXT,
    `positionOrder` INT,
    `points` DOUBLE,
    `laps` TEXT,
    `time` TEXT,
    `milliseconds` TEXT,
    `fastestLap` TEXT,
    `rank` TEXT,
    `fastestLapTime` TEXT,
    `fastestLapSpeed` TEXT,
    `statusId` INT,
    PRIMARY KEY (`resultId`),
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`),
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`),
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`)
);

DROP TABLE IF EXISTS `formula_1`.`driverStandings`;
CREATE TABLE `formula_1`.`driverStandings` (
    `driverStandingsId` INT,
    `raceId` INT,
    `driverId` INT,
    `points` DOUBLE,
    `position` INT,
    `positionText` TEXT,
    `wins` INT,
    PRIMARY KEY (`driverStandingsId`),
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`),
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`)
);

DROP TABLE IF EXISTS `formula_1`.`constructorResults`;
CREATE TABLE `formula_1`.`constructorResults` (
    `constructorResultsId` INT,
    `raceId` INT,
    `constructorId` INT,
    `points` DOUBLE,
    `status` TEXT,
    PRIMARY KEY (`constructorResultsId`),
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`),
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`)
);

DROP TABLE IF EXISTS `formula_1`.`qualifying`;
CREATE TABLE `formula_1`.`qualifying` (
    `qualifyId` INT,
    `raceId` INT,
    `driverId` INT,
    `constructorId` INT,
    `number` INT,
    `position` INT,
    `q1` TEXT,
    `q2` TEXT,
    `q3` TEXT,
    PRIMARY KEY (`qualifyId`),
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`),
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`),
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`)
);

DROP TABLE IF EXISTS `formula_1`.`pitStops`;
CREATE TABLE `formula_1`.`pitStops` (
    `raceId` INT,
    `driverId` INT,
    `stop` INT,
    `lap` INT,
    `time` TEXT,
    `duration` TEXT,
    `milliseconds` INT,
    PRIMARY KEY (`raceId`, `driverId`, `stop`),
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`),
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`)
);

DROP TABLE IF EXISTS `formula_1`.`lapTimes`;
CREATE TABLE `formula_1`.`lapTimes` (
    `raceId` INT,
    `driverId` INT,
    `lap` INT,
    `position` INT,
    `time` TEXT,
    `milliseconds` INT,
    PRIMARY KEY (`raceId`, `driverId`, `lap`),
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`),
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`)
);
