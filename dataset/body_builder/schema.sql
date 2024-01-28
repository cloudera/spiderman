CREATE DATABASE IF NOT EXISTS `body_builder`;

drop table if exists `body_builder`.`people`;
CREATE TABLE IF NOT EXISTS `body_builder`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` DOUBLE,
    `Weight` DOUBLE,
    `Birth_Date` STRING,
    `Birth_Place` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
);

drop table if exists `body_builder`.`body_builder`;
CREATE TABLE IF NOT EXISTS `body_builder`.`body_builder` (
    `Body_Builder_ID` INT,
    `People_ID` INT,
    `Snatch` DOUBLE,
    `Clean_Jerk` DOUBLE,
    `Total` DOUBLE,
    PRIMARY KEY (`Body_Builder_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `body_builder`.`people` (`People_ID`) DISABLE NOVALIDATE
);
