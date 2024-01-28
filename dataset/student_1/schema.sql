CREATE DATABASE IF NOT EXISTS `student_1`;

drop table if exists `student_1`.`list`;
CREATE TABLE IF NOT EXISTS `student_1`.`list` (
    `LastName` STRING,
    `FirstName` STRING,
    `Grade` INT,
    `Classroom` INT,
    PRIMARY KEY (`LastName`, `FirstName`) DISABLE NOVALIDATE
);

drop table if exists `student_1`.`teachers`;
CREATE TABLE IF NOT EXISTS `student_1`.`teachers` (
    `LastName` STRING,
    `FirstName` STRING,
    `Classroom` INT,
    PRIMARY KEY (`LastName`, `FirstName`) DISABLE NOVALIDATE
);
