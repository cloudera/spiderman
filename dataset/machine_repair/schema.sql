drop table if exists `machine_repair`.`repair`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`repair` (
    `repair_ID` INT,
    `name` STRING,
    `Launch_Date` STRING,
    `Notes` STRING,
    PRIMARY KEY (`repair_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/machine_repair/data/repair.csv' INTO TABLE `machine_repair`.`repair`;


drop table if exists `machine_repair`.`machine`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`machine` (
    `Machine_ID` INT,
    `Making_Year` INT,
    `Class` STRING,
    `Team` STRING,
    `Machine_series` STRING,
    `value_points` REAL,
    `quality_rank` INT,
    PRIMARY KEY (`Machine_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/machine_repair/data/machine.csv' INTO TABLE `machine_repair`.`machine`;


drop table if exists `machine_repair`.`technician`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`technician` (
    `technician_id` INT,
    `Name` STRING,
    `Team` STRING,
    `Starting_Year` REAL,
    `Age` INT,
    PRIMARY KEY (`technician_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/machine_repair/data/technician.csv' INTO TABLE `machine_repair`.`technician`;


drop table if exists `machine_repair`.`repair_assignment`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`repair_assignment` (
    `technician_id` INT,
    `repair_ID` INT,
    `Machine_ID` INT,
    PRIMARY KEY (`technician_id`, `repair_ID`, `Machine_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Machine_ID`) REFERENCES `machine_repair`.`machine` (`Machine_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`repair_ID`) REFERENCES `machine_repair`.`repair` (`repair_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`technician_id`) REFERENCES `machine_repair`.`technician` (`technician_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/machine_repair/data/repair_assignment.csv' INTO TABLE `machine_repair`.`repair_assignment`;

