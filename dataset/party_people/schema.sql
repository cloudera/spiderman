-- Dialect: MySQL | Database: party_people | Table Count: 4

CREATE DATABASE IF NOT EXISTS `party_people`;

DROP TABLE IF EXISTS `party_people`.`region`;
CREATE TABLE `party_people`.`region` (
    `Region_ID` INT,
    `Region_name` TEXT,
    `Date` TEXT,
    `Label` TEXT,
    `Format` TEXT,
    `Catalogue` TEXT,
    PRIMARY KEY (`Region_ID`)
);

DROP TABLE IF EXISTS `party_people`.`party`;
CREATE TABLE `party_people`.`party` (
    `Party_ID` INT,
    `Minister` TEXT,
    `Took_office` TEXT,
    `Left_office` TEXT,
    `Region_ID` INT,
    `Party_name` TEXT,
    PRIMARY KEY (`Party_ID`),
    FOREIGN KEY (`Region_ID`) REFERENCES `party_people`.`region` (`Region_ID`)
);

DROP TABLE IF EXISTS `party_people`.`member`;
CREATE TABLE `party_people`.`member` (
    `Member_ID` INT,
    `Member_Name` TEXT,
    `Party_ID` INT,
    `In_office` TEXT,
    PRIMARY KEY (`Member_ID`),
    FOREIGN KEY (`Party_ID`) REFERENCES `party_people`.`party` (`Party_ID`)
);

DROP TABLE IF EXISTS `party_people`.`party_events`;
CREATE TABLE `party_people`.`party_events` (
    `Event_ID` INT,
    `Event_Name` TEXT,
    `Party_ID` INT,
    `Member_in_charge_ID` INT,
    PRIMARY KEY (`Event_ID`),
    FOREIGN KEY (`Member_in_charge_ID`) REFERENCES `party_people`.`member` (`Member_ID`),
    FOREIGN KEY (`Party_ID`) REFERENCES `party_people`.`party` (`Party_ID`)
);
