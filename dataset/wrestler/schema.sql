drop table if exists `wrestler`.`wrestler`;
CREATE TABLE IF NOT EXISTS `wrestler`.`wrestler` (
    `Wrestler_ID` INT,
    `Name` STRING,
    `Reign` STRING,
    `Days_held` STRING,
    `Location` STRING,
    `Event` STRING,
    PRIMARY KEY (`Wrestler_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wrestler/data/wrestler.csv' INTO TABLE `wrestler`.`wrestler`;


drop table if exists `wrestler`.`Elimination`;
CREATE TABLE IF NOT EXISTS `wrestler`.`Elimination` (
    `Elimination_ID` STRING,
    `Wrestler_ID` INT,
    `Team` STRING,
    `Eliminated_By` STRING,
    `Elimination_Move` STRING,
    `Time` STRING,
    PRIMARY KEY (`Elimination_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Wrestler_ID`) REFERENCES `wrestler`.`wrestler` (`Wrestler_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wrestler/data/Elimination.csv' INTO TABLE `wrestler`.`Elimination`;

