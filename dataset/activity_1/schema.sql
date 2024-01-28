CREATE DATABASE IF NOT EXISTS `activity_1`;

drop table if exists `activity_1`.`Activity`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Activity` (
    `actid` INT,
    `activity_name` STRING,
    PRIMARY KEY (`actid`) DISABLE NOVALIDATE
);

drop table if exists `activity_1`.`Student`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Student` (
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

drop table if exists `activity_1`.`Participates_in`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Participates_in` (
    `stuid` INT,
    `actid` INT,
    FOREIGN KEY (`actid`) REFERENCES `activity_1`.`Activity` (`actid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`stuid`) REFERENCES `activity_1`.`Student` (`StuID`) DISABLE NOVALIDATE
);

drop table if exists `activity_1`.`Faculty`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Faculty` (
    `FacID` INT,
    `Lname` STRING,
    `Fname` STRING,
    `Rank` STRING,
    `Sex` STRING,
    `Phone` INT,
    `Room` STRING,
    `Building` STRING,
    PRIMARY KEY (`FacID`) DISABLE NOVALIDATE
);

drop table if exists `activity_1`.`Faculty_Participates_in`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Faculty_Participates_in` (
    `FacID` INT,
    `actid` INT,
    FOREIGN KEY (`actid`) REFERENCES `activity_1`.`Activity` (`actid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`FacID`) REFERENCES `activity_1`.`Faculty` (`FacID`) DISABLE NOVALIDATE
);
