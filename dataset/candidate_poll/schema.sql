CREATE DATABASE IF NOT EXISTS `candidate_poll`;

drop table if exists `candidate_poll`.`people`;
CREATE TABLE IF NOT EXISTS `candidate_poll`.`people` (
    `People_ID` INT,
    `Sex` STRING,
    `Name` STRING,
    `Date_of_Birth` STRING,
    `Height` DOUBLE,
    `Weight` DOUBLE,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
);

drop table if exists `candidate_poll`.`candidate`;
CREATE TABLE IF NOT EXISTS `candidate_poll`.`candidate` (
    `Candidate_ID` INT,
    `People_ID` INT,
    `Poll_Source` STRING,
    `Date` STRING,
    `Support_rate` DOUBLE,
    `Consider_rate` DOUBLE,
    `Oppose_rate` DOUBLE,
    `Unsure_rate` DOUBLE,
    PRIMARY KEY (`Candidate_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `candidate_poll`.`people` (`People_ID`) DISABLE NOVALIDATE
);
