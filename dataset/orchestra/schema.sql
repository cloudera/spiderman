drop table if exists `orchestra`.`conductor`;
CREATE TABLE IF NOT EXISTS `orchestra`.`conductor` (
    `Conductor_ID` INT,
    `Name` STRING,
    `Age` INT,
    `Nationality` STRING,
    `Year_of_Work` INT,
    PRIMARY KEY (`Conductor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/orchestra/data/conductor.csv' INTO TABLE `orchestra`.`conductor`;


drop table if exists `orchestra`.`orchestra`;
CREATE TABLE IF NOT EXISTS `orchestra`.`orchestra` (
    `Orchestra_ID` INT,
    `Orchestra` STRING,
    `Conductor_ID` INT,
    `Record_Company` STRING,
    `Year_of_Founded` REAL,
    `Major_Record_Format` STRING,
    PRIMARY KEY (`Orchestra_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Conductor_ID`) REFERENCES `orchestra`.`conductor` (`Conductor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/orchestra/data/orchestra.csv' INTO TABLE `orchestra`.`orchestra`;


drop table if exists `orchestra`.`performance`;
CREATE TABLE IF NOT EXISTS `orchestra`.`performance` (
    `Performance_ID` INT,
    `Orchestra_ID` INT,
    `Type` STRING,
    `Date` STRING,
    `Official_ratings_(millions)` REAL,
    `Weekly_rank` STRING,
    `Share` STRING,
    PRIMARY KEY (`Performance_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Orchestra_ID`) REFERENCES `orchestra`.`orchestra` (`Orchestra_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/orchestra/data/performance.csv' INTO TABLE `orchestra`.`performance`;


drop table if exists `orchestra`.`show`;
CREATE TABLE IF NOT EXISTS `orchestra`.`show` (
    `Show_ID` INT,
    `Performance_ID` INT,
    `If_first_show` BOOLEAN,
    `Result` STRING,
    `Attendance` REAL,
    FOREIGN KEY (`Performance_ID`) REFERENCES `orchestra`.`performance` (`Performance_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/orchestra/data/show.csv' INTO TABLE `orchestra`.`show`;

