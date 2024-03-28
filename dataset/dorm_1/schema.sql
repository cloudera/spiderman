-- Dialect: MySQL | Database: dorm_1 | Table Count: 5

CREATE DATABASE IF NOT EXISTS `dorm_1`;

DROP TABLE IF EXISTS `dorm_1`.`Student`;
CREATE TABLE `dorm_1`.`Student` (
    `StuID` INTEGER,
    `LName` VARCHAR(12),
    `Fname` VARCHAR(12),
    `Age` INTEGER,
    `Sex` VARCHAR(1),
    `Major` INTEGER,
    `Advisor` INTEGER,
    `city_code` VARCHAR(3),
    PRIMARY KEY (`StuID`)
);

DROP TABLE IF EXISTS `dorm_1`.`Dorm`;
CREATE TABLE `dorm_1`.`Dorm` (
    `dormid` INTEGER,
    `dorm_name` VARCHAR(20),
    `student_capacity` INTEGER,
    `gender` VARCHAR(1),
    UNIQUE (`dormid`)
);

DROP TABLE IF EXISTS `dorm_1`.`Dorm_amenity`;
CREATE TABLE `dorm_1`.`Dorm_amenity` (
    `amenid` INTEGER,
    `amenity_name` VARCHAR(25),
    UNIQUE (`amenid`)
);

DROP TABLE IF EXISTS `dorm_1`.`Has_amenity`;
CREATE TABLE `dorm_1`.`Has_amenity` (
    `dormid` INTEGER,
    `amenid` INTEGER,
    FOREIGN KEY (`amenid`) REFERENCES `dorm_1`.`Dorm_amenity` (`amenid`),
    FOREIGN KEY (`dormid`) REFERENCES `dorm_1`.`Dorm` (`dormid`)
);

DROP TABLE IF EXISTS `dorm_1`.`Lives_in`;
CREATE TABLE `dorm_1`.`Lives_in` (
    `stuid` INTEGER,
    `dormid` INTEGER,
    `room_number` INTEGER,
    FOREIGN KEY (`dormid`) REFERENCES `dorm_1`.`Dorm` (`dormid`),
    FOREIGN KEY (`stuid`) REFERENCES `dorm_1`.`Student` (`StuID`)
);
