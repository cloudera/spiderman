-- Dialect: MySQL | Database: csu_1 | Table Count: 6

CREATE DATABASE IF NOT EXISTS `csu_1`;

DROP TABLE IF EXISTS `csu_1`.`Campuses`;
CREATE TABLE `csu_1`.`Campuses` (
    `Id` INTEGER,
    `Campus` TEXT,
    `Location` TEXT,
    `County` TEXT,
    `Year` INTEGER,
    PRIMARY KEY (`Id`)
);

DROP TABLE IF EXISTS `csu_1`.`csu_fees`;
CREATE TABLE `csu_1`.`csu_fees` (
    `Campus` INTEGER,
    `Year` INTEGER,
    `CampusFee` INTEGER,
    PRIMARY KEY (`Campus`),
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`)
);

DROP TABLE IF EXISTS `csu_1`.`degrees`;
CREATE TABLE `csu_1`.`degrees` (
    `Year` INTEGER,
    `Campus` INTEGER,
    `Degrees` INTEGER,
    PRIMARY KEY (`Year`, `Campus`),
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`)
);

DROP TABLE IF EXISTS `csu_1`.`discipline_enrollments`;
CREATE TABLE `csu_1`.`discipline_enrollments` (
    `Campus` INTEGER,
    `Discipline` INTEGER,
    `Year` INTEGER,
    `Undergraduate` INTEGER,
    `Graduate` INTEGER,
    PRIMARY KEY (`Campus`, `Discipline`),
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`)
);

DROP TABLE IF EXISTS `csu_1`.`enrollments`;
CREATE TABLE `csu_1`.`enrollments` (
    `Campus` INTEGER,
    `Year` INTEGER,
    `TotalEnrollment_AY` INTEGER,
    `FTE_AY` INTEGER,
    PRIMARY KEY (`Campus`, `Year`),
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`)
);

DROP TABLE IF EXISTS `csu_1`.`faculty`;
CREATE TABLE `csu_1`.`faculty` (
    `Campus` INTEGER,
    `Year` INTEGER,
    `Faculty` REAL,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`)
);
