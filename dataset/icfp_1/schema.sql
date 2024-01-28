CREATE DATABASE IF NOT EXISTS `icfp_1`;

drop table if exists `icfp_1`.`Inst`;
CREATE TABLE IF NOT EXISTS `icfp_1`.`Inst` (
    `instID` INT,
    `name` STRING,
    `country` STRING,
    PRIMARY KEY (`instID`) DISABLE NOVALIDATE
);

drop table if exists `icfp_1`.`Authors`;
CREATE TABLE IF NOT EXISTS `icfp_1`.`Authors` (
    `authID` INT,
    `lname` STRING,
    `fname` STRING,
    PRIMARY KEY (`authID`) DISABLE NOVALIDATE
);

drop table if exists `icfp_1`.`Papers`;
CREATE TABLE IF NOT EXISTS `icfp_1`.`Papers` (
    `paperID` INT,
    `title` STRING,
    PRIMARY KEY (`paperID`) DISABLE NOVALIDATE
);

drop table if exists `icfp_1`.`Authorship`;
CREATE TABLE IF NOT EXISTS `icfp_1`.`Authorship` (
    `authID` INT,
    `instID` INT,
    `paperID` INT,
    `authOrder` INT,
    PRIMARY KEY (`authID`, `instID`, `paperID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`paperID`) REFERENCES `icfp_1`.`Papers` (`paperID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`instID`) REFERENCES `icfp_1`.`Inst` (`instID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`authID`) REFERENCES `icfp_1`.`Authors` (`authID`) DISABLE NOVALIDATE
);
