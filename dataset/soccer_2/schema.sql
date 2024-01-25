drop table if exists `soccer_2`.`College`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`College` (
    `cName` STRING NOT NULL,
    `state` STRING,
    `enr` NUMERIC(5,0),
    PRIMARY KEY (`cName`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_2/data/College.csv' INTO TABLE `soccer_2`.`College`;


drop table if exists `soccer_2`.`Player`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`Player` (
    `pID` NUMERIC(5,0) NOT NULL,
    `pName` STRING,
    `yCard` STRING,
    `HS` NUMERIC(5,0),
    PRIMARY KEY (`pID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_2/data/Player.csv' INTO TABLE `soccer_2`.`Player`;


drop table if exists `soccer_2`.`Tryout`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`Tryout` (
    `pID` NUMERIC(5,0),
    `cName` STRING,
    `pPos` STRING,
    `decision` STRING,
    PRIMARY KEY (`pID`, `cName`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cName`) REFERENCES `soccer_2`.`College` (`cName`) DISABLE NOVALIDATE,
    FOREIGN KEY (`pID`) REFERENCES `soccer_2`.`Player` (`pID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_2/data/Tryout.csv' INTO TABLE `soccer_2`.`Tryout`;

