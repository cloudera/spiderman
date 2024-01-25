drop table if exists `body_builder`.`people`;
CREATE TABLE IF NOT EXISTS `body_builder`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` REAL,
    `Weight` REAL,
    `Birth_Date` STRING,
    `Birth_Place` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/body_builder/data/people.csv' INTO TABLE `body_builder`.`people`;


drop table if exists `body_builder`.`body_builder`;
CREATE TABLE IF NOT EXISTS `body_builder`.`body_builder` (
    `Body_Builder_ID` INT,
    `People_ID` INT,
    `Snatch` REAL,
    `Clean_Jerk` REAL,
    `Total` REAL,
    PRIMARY KEY (`Body_Builder_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `body_builder`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/body_builder/data/body_builder.csv' INTO TABLE `body_builder`.`body_builder`;

