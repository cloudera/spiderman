-- Dialect: MySQL | Database: cinema | Table Count: 3

CREATE DATABASE IF NOT EXISTS `cinema`;

DROP TABLE IF EXISTS `cinema`.`film`;
CREATE TABLE `cinema`.`film` (
    `Film_ID` INT,
    `Rank_in_series` INT,
    `Number_in_season` INT,
    `Title` TEXT,
    `Directed_by` TEXT,
    `Original_air_date` TEXT,
    `Production_code` TEXT,
    PRIMARY KEY (`Film_ID`)
);

DROP TABLE IF EXISTS `cinema`.`cinema`;
CREATE TABLE `cinema`.`cinema` (
    `Cinema_ID` INT,
    `Name` TEXT,
    `Openning_year` INT,
    `Capacity` INT,
    `Location` TEXT,
    PRIMARY KEY (`Cinema_ID`)
);

DROP TABLE IF EXISTS `cinema`.`schedule`;
CREATE TABLE `cinema`.`schedule` (
    `Cinema_ID` INT,
    `Film_ID` INT,
    `Date` TEXT,
    `Show_times_per_day` INT,
    `Price` FLOAT,
    PRIMARY KEY (`Cinema_ID`, `Film_ID`),
    FOREIGN KEY (`Cinema_ID`) REFERENCES `cinema`.`cinema` (`Cinema_ID`),
    FOREIGN KEY (`Film_ID`) REFERENCES `cinema`.`film` (`Film_ID`)
);
