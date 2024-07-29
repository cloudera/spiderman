-- Dialect: MySQL | Database: music_4 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `music_4`;

DROP TABLE IF EXISTS `music_4`.`artist`;
CREATE TABLE `music_4`.`artist` (
    `Artist_ID` INT,
    `Artist` TEXT,
    `Age` INT,
    `Famous_Title` TEXT,
    `Famous_Release_date` TEXT,
    PRIMARY KEY (`Artist_ID`)
);

DROP TABLE IF EXISTS `music_4`.`volume`;
CREATE TABLE `music_4`.`volume` (
    `Volume_ID` INT,
    `Volume_Issue` TEXT,
    `Issue_Date` TEXT,
    `Weeks_on_Top` REAL,
    `Song` TEXT,
    `Artist_ID` INT,
    PRIMARY KEY (`Volume_ID`),
    FOREIGN KEY (`Artist_ID`) REFERENCES `music_4`.`artist` (`Artist_ID`)
);

DROP TABLE IF EXISTS `music_4`.`music_festival`;
CREATE TABLE `music_4`.`music_festival` (
    `ID` INT,
    `Music_Festival` TEXT,
    `Date_of_ceremony` TEXT,
    `Category` TEXT,
    `Volume` INT,
    `Result` TEXT,
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`Volume`) REFERENCES `music_4`.`volume` (`Volume_ID`)
);
