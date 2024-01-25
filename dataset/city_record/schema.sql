drop table if exists `city_record`.`city`;
CREATE TABLE IF NOT EXISTS `city_record`.`city` (
    `City_ID` INT,
    `City` STRING,
    `Hanzi` STRING,
    `Hanyu_Pinyin` STRING,
    `Regional_Population` INT,
    `GDP` REAL,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/city_record/data/city.csv' INTO TABLE `city_record`.`city`;


drop table if exists `city_record`.`match`;
CREATE TABLE IF NOT EXISTS `city_record`.`match` (
    `Match_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Score` STRING,
    `Result` STRING,
    `Competition` STRING,
    PRIMARY KEY (`Match_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/city_record/data/match.csv' INTO TABLE `city_record`.`match`;


drop table if exists `city_record`.`temperature`;
CREATE TABLE IF NOT EXISTS `city_record`.`temperature` (
    `City_ID` INT,
    `Jan` REAL,
    `Feb` REAL,
    `Mar` REAL,
    `Apr` REAL,
    `Jun` REAL,
    `Jul` REAL,
    `Aug` REAL,
    `Sep` REAL,
    `Oct` REAL,
    `Nov` REAL,
    `Dec` REAL,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`City_ID`) REFERENCES `city_record`.`city` (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/city_record/data/temperature.csv' INTO TABLE `city_record`.`temperature`;


drop table if exists `city_record`.`hosting_city`;
CREATE TABLE IF NOT EXISTS `city_record`.`hosting_city` (
    `Year` INT,
    `Match_ID` INT,
    `Host_City` INT,
    PRIMARY KEY (`Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Match_ID`) REFERENCES `city_record`.`match` (`Match_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Host_City`) REFERENCES `city_record`.`city` (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/city_record/data/hosting_city.csv' INTO TABLE `city_record`.`hosting_city`;

