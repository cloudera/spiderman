-- Dialect: mysql | Database: machine_repair | Table Count: 4

CREATE TABLE `machine_repair`.`repair` (
    `repair_ID` INT,
    `name` TEXT,
    `Launch_Date` TEXT,
    `Notes` TEXT,
    PRIMARY KEY (`repair_ID`)
);

CREATE TABLE `machine_repair`.`machine` (
    `Machine_ID` INT,
    `Making_Year` INT,
    `Class` TEXT,
    `Team` TEXT,
    `Machine_series` TEXT,
    `value_points` REAL,
    `quality_rank` INT,
    PRIMARY KEY (`Machine_ID`)
);

CREATE TABLE `machine_repair`.`technician` (
    `technician_id` INT,
    `Name` TEXT,
    `Team` TEXT,
    `Starting_Year` REAL,
    `Age` INT,
    PRIMARY KEY (`technician_id`)
);

CREATE TABLE `machine_repair`.`repair_assignment` (
    `technician_id` INT,
    `repair_ID` INT,
    `Machine_ID` INT,
    PRIMARY KEY (`technician_id`, `repair_ID`, `Machine_ID`),
    FOREIGN KEY (`Machine_ID`) REFERENCES `machine_repair`.`machine` (`Machine_ID`),
    FOREIGN KEY (`repair_ID`) REFERENCES `machine_repair`.`repair` (`repair_ID`),
    FOREIGN KEY (`technician_id`) REFERENCES `machine_repair`.`technician` (`technician_id`)
);
