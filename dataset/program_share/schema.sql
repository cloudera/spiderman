drop table if exists `program_share`.`program`;
CREATE TABLE IF NOT EXISTS `program_share`.`program` (
    `Program_ID` INT,
    `Name` STRING,
    `Origin` STRING,
    `Launch` REAL,
    `Owner` STRING,
    PRIMARY KEY (`Program_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/program_share/data/program.csv' INTO TABLE `program_share`.`program`;


drop table if exists `program_share`.`channel`;
CREATE TABLE IF NOT EXISTS `program_share`.`channel` (
    `Channel_ID` INT,
    `Name` STRING,
    `Owner` STRING,
    `Share_in_percent` REAL,
    `Rating_in_percent` REAL,
    PRIMARY KEY (`Channel_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/program_share/data/channel.csv' INTO TABLE `program_share`.`channel`;


drop table if exists `program_share`.`broadcast`;
CREATE TABLE IF NOT EXISTS `program_share`.`broadcast` (
    `Channel_ID` INT,
    `Program_ID` INT,
    `Time_of_day` STRING,
    PRIMARY KEY (`Channel_ID`, `Program_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Program_ID`) REFERENCES `program_share`.`program` (`Program_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel_ID`) REFERENCES `program_share`.`channel` (`Channel_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/program_share/data/broadcast.csv' INTO TABLE `program_share`.`broadcast`;


drop table if exists `program_share`.`broadcast_share`;
CREATE TABLE IF NOT EXISTS `program_share`.`broadcast_share` (
    `Channel_ID` INT,
    `Program_ID` INT,
    `Date` STRING,
    `Share_in_percent` REAL,
    PRIMARY KEY (`Channel_ID`, `Program_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Program_ID`) REFERENCES `program_share`.`program` (`Program_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel_ID`) REFERENCES `program_share`.`channel` (`Channel_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/program_share/data/broadcast_share.csv' INTO TABLE `program_share`.`broadcast_share`;
