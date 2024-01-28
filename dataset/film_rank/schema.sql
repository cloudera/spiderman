CREATE DATABASE IF NOT EXISTS `film_rank`;

drop table if exists `film_rank`.`film`;
CREATE TABLE IF NOT EXISTS `film_rank`.`film` (
    `Film_ID` INT,
    `Title` STRING,
    `Studio` STRING,
    `Director` STRING,
    `Gross_in_dollar` INT,
    PRIMARY KEY (`Film_ID`) DISABLE NOVALIDATE
);

drop table if exists `film_rank`.`market`;
CREATE TABLE IF NOT EXISTS `film_rank`.`market` (
    `Market_ID` INT,
    `Country` STRING,
    `Number_cities` INT,
    PRIMARY KEY (`Market_ID`) DISABLE NOVALIDATE
);

drop table if exists `film_rank`.`film_market_estimation`;
CREATE TABLE IF NOT EXISTS `film_rank`.`film_market_estimation` (
    `Estimation_ID` INT,
    `Low_Estimate` DOUBLE,
    `High_Estimate` DOUBLE,
    `Film_ID` INT,
    `Type` STRING,
    `Market_ID` INT,
    `Year` INT,
    PRIMARY KEY (`Estimation_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Market_ID`) REFERENCES `film_rank`.`market` (`Market_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Film_ID`) REFERENCES `film_rank`.`film` (`Film_ID`) DISABLE NOVALIDATE
);
