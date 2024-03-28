-- Dialect: MySQL | Database: movie_1 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `movie_1`;

DROP TABLE IF EXISTS `movie_1`.`Movie`;
CREATE TABLE `movie_1`.`Movie` (
    `mID` INT,
    `title` TEXT,
    `year` INT,
    `director` TEXT,
    PRIMARY KEY (`mID`)
);

DROP TABLE IF EXISTS `movie_1`.`Reviewer`;
CREATE TABLE `movie_1`.`Reviewer` (
    `rID` INT,
    `name` TEXT,
    PRIMARY KEY (`rID`)
);

DROP TABLE IF EXISTS `movie_1`.`Rating`;
CREATE TABLE `movie_1`.`Rating` (
    `rID` INT,
    `mID` INT,
    `stars` INT,
    `ratingDate` DATE,
    FOREIGN KEY (`rID`) REFERENCES `movie_1`.`Reviewer` (`rID`),
    FOREIGN KEY (`mID`) REFERENCES `movie_1`.`Movie` (`mID`)
);
