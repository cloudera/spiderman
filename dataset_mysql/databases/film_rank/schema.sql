-- Dialect: MySQL | Database: film_rank | Table Count: 3

CREATE DATABASE IF NOT EXISTS `film_rank`;

DROP TABLE IF EXISTS `film_rank`.`film`;
CREATE TABLE `film_rank`.`film` (
    `Film_ID` INT,
    `Title` TEXT,
    `Studio` TEXT,
    `Director` TEXT,
    `Gross_in_dollar` INT,
    PRIMARY KEY (`Film_ID`)
);

DROP TABLE IF EXISTS `film_rank`.`market`;
CREATE TABLE `film_rank`.`market` (
    `Market_ID` INT,
    `Country` TEXT,
    `Number_cities` INT,
    PRIMARY KEY (`Market_ID`)
);

DROP TABLE IF EXISTS `film_rank`.`film_market_estimation`;
CREATE TABLE `film_rank`.`film_market_estimation` (
    `Estimation_ID` INT,
    `Low_Estimate` REAL,
    `High_Estimate` REAL,
    `Film_ID` INT,
    `Type` TEXT,
    `Market_ID` INT,
    `Year` INT,
    PRIMARY KEY (`Estimation_ID`),
    FOREIGN KEY (`Market_ID`) REFERENCES `film_rank`.`market` (`Market_ID`),
    FOREIGN KEY (`Film_ID`) REFERENCES `film_rank`.`film` (`Film_ID`)
);
