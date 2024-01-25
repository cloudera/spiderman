drop table if exists `cinema`.`film`;
CREATE TABLE IF NOT EXISTS `cinema`.`film` (
    `Film_ID` INT,
    `Rank_in_series` INT,
    `Number_in_season` INT,
    `Title` STRING,
    `Directed_by` STRING,
    `Original_air_date` STRING,
    `Production_code` STRING,
    PRIMARY KEY (`Film_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cinema/data/film.csv' INTO TABLE `cinema`.`film`;


drop table if exists `cinema`.`cinema`;
CREATE TABLE IF NOT EXISTS `cinema`.`cinema` (
    `Cinema_ID` INT,
    `Name` STRING,
    `Openning_year` INT,
    `Capacity` INT,
    `Location` STRING,
    PRIMARY KEY (`Cinema_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cinema/data/cinema.csv' INTO TABLE `cinema`.`cinema`;


drop table if exists `cinema`.`schedule`;
CREATE TABLE IF NOT EXISTS `cinema`.`schedule` (
    `Cinema_ID` INT,
    `Film_ID` INT,
    `Date` STRING,
    `Show_times_per_day` INT,
    `Price` DECIMAL,
    PRIMARY KEY (`Cinema_ID`, `Film_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Cinema_ID`) REFERENCES `cinema`.`cinema` (`Cinema_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Film_ID`) REFERENCES `cinema`.`film` (`Film_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cinema/data/schedule.csv' INTO TABLE `cinema`.`schedule`;

