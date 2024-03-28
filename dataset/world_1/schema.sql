-- Dialect: MySQL | Database: world_1 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `world_1`;

DROP TABLE IF EXISTS `world_1`.`country`;
CREATE TABLE `world_1`.`country` (
    `Code` CHAR(3) NOT NULL,
    `Name` CHAR(52) NOT NULL DEFAULT '',
    `Continent` VARCHAR(30) NOT NULL DEFAULT 'Asia',
    `Region` CHAR(26) NOT NULL DEFAULT '',
    `SurfaceArea` FLOAT(10,2) NOT NULL DEFAULT '0.00',
    `IndepYear` INTEGER DEFAULT NULL,
    `Population` INTEGER NOT NULL DEFAULT '0',
    `LifeExpectancy` FLOAT(3,1) DEFAULT NULL,
    `GNP` FLOAT(10,2) DEFAULT NULL,
    `GNPOld` FLOAT(10,2) DEFAULT NULL,
    `LocalName` CHAR(45) NOT NULL DEFAULT '',
    `GovernmentForm` CHAR(45) NOT NULL DEFAULT '',
    `HeadOfState` CHAR(60) DEFAULT NULL,
    `Capital` INTEGER DEFAULT NULL,
    `Code2` CHAR(2) NOT NULL DEFAULT '',
    PRIMARY KEY (`Code`)
);

DROP TABLE IF EXISTS `world_1`.`city`;
CREATE TABLE `world_1`.`city` (
    `ID` INTEGER NOT NULL,
    `Name` CHAR(35) NOT NULL DEFAULT '',
    `CountryCode` CHAR(3) NOT NULL DEFAULT '',
    `District` CHAR(20) NOT NULL DEFAULT '',
    `Population` INTEGER NOT NULL DEFAULT '0',
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`CountryCode`) REFERENCES `world_1`.`country` (`Code`)
);

DROP TABLE IF EXISTS `world_1`.`countrylanguage`;
CREATE TABLE `world_1`.`countrylanguage` (
    `CountryCode` CHAR(3) NOT NULL,
    `Language` CHAR(30) NOT NULL,
    `IsOfficial` VARCHAR(5) NOT NULL DEFAULT 'F',
    `Percentage` FLOAT(4,1) NOT NULL DEFAULT '0.0',
    PRIMARY KEY (`CountryCode`, `Language`),
    FOREIGN KEY (`CountryCode`) REFERENCES `world_1`.`country` (`Code`)
);
