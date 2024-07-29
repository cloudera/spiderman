-- Dialect: MySQL | Database: student_1 | Table Count: 2

CREATE DATABASE IF NOT EXISTS `student_1`;

DROP TABLE IF EXISTS `student_1`.`list`;
CREATE TABLE `student_1`.`list` (
    `LastName` VARCHAR(50),
    `FirstName` VARCHAR(50),
    `Grade` INTEGER,
    `Classroom` INTEGER,
    PRIMARY KEY (`LastName`, `FirstName`)
);

DROP TABLE IF EXISTS `student_1`.`teachers`;
CREATE TABLE `student_1`.`teachers` (
    `LastName` VARCHAR(50),
    `FirstName` VARCHAR(50),
    `Classroom` INTEGER,
    PRIMARY KEY (`LastName`, `FirstName`)
);
