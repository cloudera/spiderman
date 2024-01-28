CREATE DATABASE IF NOT EXISTS `dorm_1`;

drop table if exists `dorm_1`.`Student`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
);

drop table if exists `dorm_1`.`Dorm`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Dorm` (
    `dormid` INT,
    `dorm_name` STRING,
    `student_capacity` INT,
    `gender` STRING,
    UNIQUE (`dormid`) DISABLE NOVALIDATE
);

drop table if exists `dorm_1`.`Dorm_amenity`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Dorm_amenity` (
    `amenid` INT,
    `amenity_name` STRING,
    UNIQUE (`amenid`) DISABLE NOVALIDATE
);

drop table if exists `dorm_1`.`Has_amenity`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Has_amenity` (
    `dormid` INT,
    `amenid` INT,
    FOREIGN KEY (`amenid`) REFERENCES `dorm_1`.`Dorm_amenity` (`amenid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dormid`) REFERENCES `dorm_1`.`Dorm` (`dormid`) DISABLE NOVALIDATE
);

drop table if exists `dorm_1`.`Lives_in`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Lives_in` (
    `stuid` INT,
    `dormid` INT,
    `room_number` INT,
    FOREIGN KEY (`dormid`) REFERENCES `dorm_1`.`Dorm` (`dormid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`stuid`) REFERENCES `dorm_1`.`Student` (`StuID`) DISABLE NOVALIDATE
);
