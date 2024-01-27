CREATE DATABASE IF NOT EXISTS `candidate_poll`;

drop table if exists `candidate_poll`.`people`;
CREATE TABLE IF NOT EXISTS `candidate_poll`.`people` (
    `People_ID` INT,
    `Sex` STRING,
    `Name` STRING,
    `Date_of_Birth` STRING,
    `Height` REAL,
    `Weight` REAL,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/candidate_poll/data/people.csv' INTO TABLE `candidate_poll`.`people`;


drop table if exists `candidate_poll`.`candidate`;
CREATE TABLE IF NOT EXISTS `candidate_poll`.`candidate` (
    `Candidate_ID` INT,
    `People_ID` INT,
    `Poll_Source` STRING,
    `Date` STRING,
    `Support_rate` REAL,
    `Consider_rate` REAL,
    `Oppose_rate` REAL,
    `Unsure_rate` REAL,
    PRIMARY KEY (`Candidate_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `candidate_poll`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/candidate_poll/data/candidate.csv' INTO TABLE `candidate_poll`.`candidate`;

