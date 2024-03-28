-- Dialect: MySQL | Database: college_3 | Table Count: 8

CREATE DATABASE IF NOT EXISTS `college_3`;

DROP TABLE IF EXISTS `college_3`.`Student`;
CREATE TABLE `college_3`.`Student` (
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

DROP TABLE IF EXISTS `college_3`.`Faculty`;
CREATE TABLE `college_3`.`Faculty` (
    `FacID` INTEGER,
    `Lname` VARCHAR(15),
    `Fname` VARCHAR(15),
    `Rank` VARCHAR(15),
    `Sex` VARCHAR(1),
    `Phone` INTEGER,
    `Room` VARCHAR(5),
    `Building` VARCHAR(13),
    PRIMARY KEY (`FacID`)
);

DROP TABLE IF EXISTS `college_3`.`Department`;
CREATE TABLE `college_3`.`Department` (
    `DNO` INTEGER,
    `Division` VARCHAR(2),
    `DName` VARCHAR(25),
    `Room` VARCHAR(5),
    `Building` VARCHAR(13),
    `DPhone` INTEGER,
    PRIMARY KEY (`DNO`)
);

DROP TABLE IF EXISTS `college_3`.`Member_of`;
CREATE TABLE `college_3`.`Member_of` (
    `FacID` INTEGER,
    `DNO` INTEGER,
    `Appt_Type` VARCHAR(15),
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`),
    FOREIGN KEY (`FacID`) REFERENCES `college_3`.`Faculty` (`FacID`)
);

DROP TABLE IF EXISTS `college_3`.`Course`;
CREATE TABLE `college_3`.`Course` (
    `CID` VARCHAR(7),
    `CName` VARCHAR(40),
    `Credits` INTEGER,
    `Instructor` INTEGER,
    `Days` VARCHAR(5),
    `Hours` VARCHAR(11),
    `DNO` INTEGER,
    PRIMARY KEY (`CID`),
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`),
    FOREIGN KEY (`Instructor`) REFERENCES `college_3`.`Faculty` (`FacID`)
);

DROP TABLE IF EXISTS `college_3`.`Minor_in`;
CREATE TABLE `college_3`.`Minor_in` (
    `StuID` INTEGER,
    `DNO` INTEGER,
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`),
    FOREIGN KEY (`StuID`) REFERENCES `college_3`.`Student` (`StuID`)
);

DROP TABLE IF EXISTS `college_3`.`Gradeconversion`;
CREATE TABLE `college_3`.`Gradeconversion` (
    `lettergrade` VARCHAR(2),
    `gradepoint` FLOAT,
    PRIMARY KEY (`lettergrade`)
);

DROP TABLE IF EXISTS `college_3`.`Enrolled_in`;
CREATE TABLE `college_3`.`Enrolled_in` (
    `StuID` INTEGER,
    `CID` VARCHAR(7),
    `Grade` VARCHAR(2),
    FOREIGN KEY (`Grade`) REFERENCES `college_3`.`Gradeconversion` (`lettergrade`),
    FOREIGN KEY (`CID`) REFERENCES `college_3`.`Course` (`CID`),
    FOREIGN KEY (`StuID`) REFERENCES `college_3`.`Student` (`StuID`)
);
