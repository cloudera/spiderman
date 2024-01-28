CREATE DATABASE IF NOT EXISTS `machine_repair`;

drop table if exists `machine_repair`.`repair`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`repair` (
    `repair_ID` INT,
    `name` STRING,
    `Launch_Date` STRING,
    `Notes` STRING,
    PRIMARY KEY (`repair_ID`) DISABLE NOVALIDATE
);

drop table if exists `machine_repair`.`machine`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`machine` (
    `Machine_ID` INT,
    `Making_Year` INT,
    `Class` STRING,
    `Team` STRING,
    `Machine_series` STRING,
    `value_points` DOUBLE,
    `quality_rank` INT,
    PRIMARY KEY (`Machine_ID`) DISABLE NOVALIDATE
);

drop table if exists `machine_repair`.`technician`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`technician` (
    `technician_id` INT,
    `Name` STRING,
    `Team` STRING,
    `Starting_Year` DOUBLE,
    `Age` INT,
    PRIMARY KEY (`technician_id`) DISABLE NOVALIDATE
);

drop table if exists `machine_repair`.`repair_assignment`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`repair_assignment` (
    `technician_id` INT,
    `repair_ID` INT,
    `Machine_ID` INT,
    PRIMARY KEY (`technician_id`, `repair_ID`, `Machine_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Machine_ID`) REFERENCES `machine_repair`.`machine` (`Machine_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`repair_ID`) REFERENCES `machine_repair`.`repair` (`repair_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`technician_id`) REFERENCES `machine_repair`.`technician` (`technician_id`) DISABLE NOVALIDATE
);
