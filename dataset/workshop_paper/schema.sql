CREATE DATABASE IF NOT EXISTS `workshop_paper`;

drop table if exists `workshop_paper`.`workshop`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`workshop` (
    `Workshop_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Name` STRING,
    PRIMARY KEY (`Workshop_ID`) DISABLE NOVALIDATE
);

drop table if exists `workshop_paper`.`submission`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`submission` (
    `Submission_ID` INT,
    `Scores` DOUBLE,
    `Author` STRING,
    `College` STRING,
    PRIMARY KEY (`Submission_ID`) DISABLE NOVALIDATE
);

drop table if exists `workshop_paper`.`Acceptance`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`Acceptance` (
    `Submission_ID` INT,
    `Workshop_ID` INT,
    `Result` STRING,
    PRIMARY KEY (`Submission_ID`, `Workshop_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Workshop_ID`) REFERENCES `workshop_paper`.`workshop` (`Workshop_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Submission_ID`) REFERENCES `workshop_paper`.`submission` (`Submission_ID`) DISABLE NOVALIDATE
);
