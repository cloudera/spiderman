-- Dialect: mysql | Database: movie_1 | Table Count: 3

CREATE TABLE `movie_1`.`Movie` (
    `mID` INT,
    `title` TEXT,
    `year` INT,
    `director` TEXT,
    PRIMARY KEY (`mID`)
);

CREATE TABLE `movie_1`.`Reviewer` (
    `rID` INT,
    `name` TEXT,
    PRIMARY KEY (`rID`)
);

CREATE TABLE `movie_1`.`Rating` (
    `rID` INT,
    `mID` INT,
    `stars` INT,
    `ratingDate` DATE,
    FOREIGN KEY (`rID`) REFERENCES `movie_1`.`Reviewer` (`rID`),
    FOREIGN KEY (`mID`) REFERENCES `movie_1`.`Movie` (`mID`)
);
