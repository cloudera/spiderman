-- Dialect: MySQL | Database: body_builder | Table Count: 2

CREATE DATABASE IF NOT EXISTS `body_builder`;

DROP TABLE IF EXISTS `body_builder`.`people`;
CREATE TABLE `body_builder`.`people` (
    `People_ID` INT,
    `Name` TEXT,
    `Height` REAL,
    `Weight` REAL,
    `Birth_Date` TEXT,
    `Birth_Place` TEXT,
    PRIMARY KEY (`People_ID`)
);

DROP TABLE IF EXISTS `body_builder`.`body_builder`;
CREATE TABLE `body_builder`.`body_builder` (
    `Body_Builder_ID` INT,
    `People_ID` INT,
    `Snatch` REAL,
    `Clean_Jerk` REAL,
    `Total` REAL,
    PRIMARY KEY (`Body_Builder_ID`),
    FOREIGN KEY (`People_ID`) REFERENCES `body_builder`.`people` (`People_ID`)
);
