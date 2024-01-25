drop table if exists `workshop_paper`.`workshop`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`workshop` (
    `Workshop_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Name` STRING,
    PRIMARY KEY (`Workshop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/workshop_paper/data/workshop.csv' INTO TABLE `workshop_paper`.`workshop`;


drop table if exists `workshop_paper`.`submission`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`submission` (
    `Submission_ID` INT,
    `Scores` REAL,
    `Author` STRING,
    `College` STRING,
    PRIMARY KEY (`Submission_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/workshop_paper/data/submission.csv' INTO TABLE `workshop_paper`.`submission`;


drop table if exists `workshop_paper`.`Acceptance`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`Acceptance` (
    `Submission_ID` INT,
    `Workshop_ID` INT,
    `Result` STRING,
    PRIMARY KEY (`Submission_ID`, `Workshop_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Workshop_ID`) REFERENCES `workshop_paper`.`workshop` (`Workshop_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Submission_ID`) REFERENCES `workshop_paper`.`submission` (`Submission_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/workshop_paper/data/Acceptance.csv' INTO TABLE `workshop_paper`.`Acceptance`;

