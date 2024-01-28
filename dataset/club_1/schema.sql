CREATE DATABASE IF NOT EXISTS `club_1`;

drop table if exists `club_1`.`Student`;
CREATE TABLE IF NOT EXISTS `club_1`.`Student` (
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

drop table if exists `club_1`.`Club`;
CREATE TABLE IF NOT EXISTS `club_1`.`Club` (
    `ClubID` INT,
    `ClubName` STRING,
    `ClubDesc` STRING,
    `ClubLocation` STRING,
    PRIMARY KEY (`ClubID`) DISABLE NOVALIDATE
);

drop table if exists `club_1`.`Member_of_club`;
CREATE TABLE IF NOT EXISTS `club_1`.`Member_of_club` (
    `StuID` INT,
    `ClubID` INT,
    `Position` STRING,
    FOREIGN KEY (`ClubID`) REFERENCES `club_1`.`Club` (`ClubID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `club_1`.`Student` (`StuID`) DISABLE NOVALIDATE
);
