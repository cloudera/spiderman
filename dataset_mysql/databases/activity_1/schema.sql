-- Dialect: MySQL | Database: activity_1 | Table Count: 5

CREATE DATABASE IF NOT EXISTS `activity_1`;

DROP TABLE IF EXISTS `activity_1`.`Activity`;
CREATE TABLE `activity_1`.`Activity` (
    `actid` INTEGER,
    `activity_name` VARCHAR(25),
    PRIMARY KEY (`actid`)
);

DROP TABLE IF EXISTS `activity_1`.`Student`;
CREATE TABLE `activity_1`.`Student` (
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

DROP TABLE IF EXISTS `activity_1`.`Participates_in`;
CREATE TABLE `activity_1`.`Participates_in` (
    `stuid` INTEGER,
    `actid` INTEGER,
    FOREIGN KEY (`actid`) REFERENCES `activity_1`.`Activity` (`actid`),
    FOREIGN KEY (`stuid`) REFERENCES `activity_1`.`Student` (`StuID`)
);

DROP TABLE IF EXISTS `activity_1`.`Faculty`;
CREATE TABLE `activity_1`.`Faculty` (
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

DROP TABLE IF EXISTS `activity_1`.`Faculty_Participates_in`;
CREATE TABLE `activity_1`.`Faculty_Participates_in` (
    `FacID` INTEGER,
    `actid` INTEGER,
    FOREIGN KEY (`actid`) REFERENCES `activity_1`.`Activity` (`actid`),
    FOREIGN KEY (`FacID`) REFERENCES `activity_1`.`Faculty` (`FacID`)
);
