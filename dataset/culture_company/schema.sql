CREATE DATABASE IF NOT EXISTS `culture_company`;

drop table if exists `culture_company`.`book_club`;
CREATE TABLE IF NOT EXISTS `culture_company`.`book_club` (
    `book_club_id` INT,
    `Year` INT,
    `Author_or_Editor` STRING,
    `Book_Title` STRING,
    `Publisher` STRING,
    `Category` STRING,
    `Result` STRING,
    PRIMARY KEY (`book_club_id`) DISABLE NOVALIDATE
);

drop table if exists `culture_company`.`movie`;
CREATE TABLE IF NOT EXISTS `culture_company`.`movie` (
    `movie_id` INT,
    `Title` STRING,
    `Year` INT,
    `Director` STRING,
    `Budget_million` DOUBLE,
    `Gross_worldwide` INT,
    PRIMARY KEY (`movie_id`) DISABLE NOVALIDATE
);

drop table if exists `culture_company`.`culture_company`;
CREATE TABLE IF NOT EXISTS `culture_company`.`culture_company` (
    `Company_name` STRING,
    `Type` STRING,
    `Incorporated_in` STRING,
    `Group_Equity_Shareholding` DOUBLE,
    `book_club_id` INT,
    `movie_id` INT,
    PRIMARY KEY (`Company_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`movie_id`) REFERENCES `culture_company`.`movie` (`movie_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`book_club_id`) REFERENCES `culture_company`.`book_club` (`book_club_id`) DISABLE NOVALIDATE
);
