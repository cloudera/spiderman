-- Dialect: MySQL | Database: culture_company | Table Count: 3

CREATE DATABASE IF NOT EXISTS `culture_company`;

DROP TABLE IF EXISTS `culture_company`.`book_club`;
CREATE TABLE `culture_company`.`book_club` (
    `book_club_id` INT,
    `Year` INT,
    `Author_or_Editor` TEXT,
    `Book_Title` TEXT,
    `Publisher` TEXT,
    `Category` TEXT,
    `Result` TEXT,
    PRIMARY KEY (`book_club_id`)
);

DROP TABLE IF EXISTS `culture_company`.`movie`;
CREATE TABLE `culture_company`.`movie` (
    `movie_id` INT,
    `Title` TEXT,
    `Year` INT,
    `Director` TEXT,
    `Budget_million` REAL,
    `Gross_worldwide` INT,
    PRIMARY KEY (`movie_id`)
);

DROP TABLE IF EXISTS `culture_company`.`culture_company`;
CREATE TABLE `culture_company`.`culture_company` (
    `Company_name` VARCHAR(50),
    `Type` TEXT,
    `Incorporated_in` TEXT,
    `Group_Equity_Shareholding` REAL,
    `book_club_id` INT,
    `movie_id` INT,
    PRIMARY KEY (`Company_name`),
    FOREIGN KEY (`movie_id`) REFERENCES `culture_company`.`movie` (`movie_id`),
    FOREIGN KEY (`book_club_id`) REFERENCES `culture_company`.`book_club` (`book_club_id`)
);
