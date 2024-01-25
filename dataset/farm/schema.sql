drop table if exists `farm`.`city`;
CREATE TABLE IF NOT EXISTS `farm`.`city` (
    `City_ID` INT,
    `Official_Name` STRING,
    `Status` STRING,
    `Area_km_2` REAL,
    `Population` REAL,
    `Census_Ranking` STRING,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/farm/data/city.csv' INTO TABLE `farm`.`city`;


drop table if exists `farm`.`farm`;
CREATE TABLE IF NOT EXISTS `farm`.`farm` (
    `Farm_ID` INT,
    `Year` INT,
    `Total_Horses` REAL,
    `Working_Horses` REAL,
    `Total_Cattle` REAL,
    `Oxen` REAL,
    `Bulls` REAL,
    `Cows` REAL,
    `Pigs` REAL,
    `Sheep_and_Goats` REAL,
    PRIMARY KEY (`Farm_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/farm/data/farm.csv' INTO TABLE `farm`.`farm`;


drop table if exists `farm`.`farm_competition`;
CREATE TABLE IF NOT EXISTS `farm`.`farm_competition` (
    `Competition_ID` INT,
    `Year` INT,
    `Theme` STRING,
    `Host_city_ID` INT,
    `Hosts` STRING,
    PRIMARY KEY (`Competition_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Host_city_ID`) REFERENCES `farm`.`city` (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/farm/data/farm_competition.csv' INTO TABLE `farm`.`farm_competition`;


drop table if exists `farm`.`competition_record`;
CREATE TABLE IF NOT EXISTS `farm`.`competition_record` (
    `Competition_ID` INT,
    `Farm_ID` INT,
    `Rank` INT,
    PRIMARY KEY (`Competition_ID`, `Farm_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Farm_ID`) REFERENCES `farm`.`farm` (`Farm_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Competition_ID`) REFERENCES `farm`.`farm_competition` (`Competition_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/farm/data/competition_record.csv' INTO TABLE `farm`.`competition_record`;

