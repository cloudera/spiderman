CREATE DATABASE IF NOT EXISTS `movie_1`;

drop table if exists `movie_1`.`Movie`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Movie` (
    `mID` INT,
    `title` STRING,
    `year` INT,
    `director` STRING,
    PRIMARY KEY (`mID`) DISABLE NOVALIDATE
);

drop table if exists `movie_1`.`Reviewer`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Reviewer` (
    `rID` INT,
    `name` STRING,
    PRIMARY KEY (`rID`) DISABLE NOVALIDATE
);

drop table if exists `movie_1`.`Rating`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Rating` (
    `rID` INT,
    `mID` INT,
    `stars` INT,
    `ratingDate` DATE,
    FOREIGN KEY (`rID`) REFERENCES `movie_1`.`Reviewer` (`rID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`mID`) REFERENCES `movie_1`.`Movie` (`mID`) DISABLE NOVALIDATE
);
