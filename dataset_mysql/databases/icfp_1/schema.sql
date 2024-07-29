-- Dialect: MySQL | Database: icfp_1 | Table Count: 4

CREATE DATABASE IF NOT EXISTS `icfp_1`;

DROP TABLE IF EXISTS `icfp_1`.`Inst`;
CREATE TABLE `icfp_1`.`Inst` (
    `instID` INTEGER,
    `name` TEXT,
    `country` TEXT,
    PRIMARY KEY (`instID`)
);

DROP TABLE IF EXISTS `icfp_1`.`Authors`;
CREATE TABLE `icfp_1`.`Authors` (
    `authID` INTEGER,
    `lname` TEXT,
    `fname` TEXT,
    PRIMARY KEY (`authID`)
);

DROP TABLE IF EXISTS `icfp_1`.`Papers`;
CREATE TABLE `icfp_1`.`Papers` (
    `paperID` INTEGER,
    `title` TEXT,
    PRIMARY KEY (`paperID`)
);

DROP TABLE IF EXISTS `icfp_1`.`Authorship`;
CREATE TABLE `icfp_1`.`Authorship` (
    `authID` INTEGER,
    `instID` INTEGER,
    `paperID` INTEGER,
    `authOrder` INTEGER,
    PRIMARY KEY (`authID`, `instID`, `paperID`),
    FOREIGN KEY (`paperID`) REFERENCES `icfp_1`.`Papers` (`paperID`),
    FOREIGN KEY (`instID`) REFERENCES `icfp_1`.`Inst` (`instID`),
    FOREIGN KEY (`authID`) REFERENCES `icfp_1`.`Authors` (`authID`)
);
