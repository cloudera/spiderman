drop table if exists `journal_committee`.`journal`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`journal` (
    `Journal_ID` INT,
    `Date` STRING,
    `Theme` STRING,
    `Sales` INT,
    PRIMARY KEY (`Journal_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/journal_committee/data/journal.csv' INTO TABLE `journal_committee`.`journal`;


drop table if exists `journal_committee`.`editor`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`editor` (
    `Editor_ID` INT,
    `Name` STRING,
    `Age` REAL,
    PRIMARY KEY (`Editor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/journal_committee/data/editor.csv' INTO TABLE `journal_committee`.`editor`;


drop table if exists `journal_committee`.`journal_committee`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`journal_committee` (
    `Editor_ID` INT,
    `Journal_ID` INT,
    `Work_Type` STRING,
    PRIMARY KEY (`Editor_ID`, `Journal_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Journal_ID`) REFERENCES `journal_committee`.`journal` (`Journal_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Editor_ID`) REFERENCES `journal_committee`.`editor` (`Editor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/journal_committee/data/journal_committee.csv' INTO TABLE `journal_committee`.`journal_committee`;

