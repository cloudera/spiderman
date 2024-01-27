CREATE DATABASE IF NOT EXISTS `entertainment_awards`;

drop table if exists `entertainment_awards`.`festival_detail`;
CREATE TABLE IF NOT EXISTS `entertainment_awards`.`festival_detail` (
    `Festival_ID` INT,
    `Festival_Name` STRING,
    `Chair_Name` STRING,
    `Location` STRING,
    `Year` INT,
    `Num_of_Audience` INT,
    PRIMARY KEY (`Festival_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entertainment_awards/data/festival_detail.csv' INTO TABLE `entertainment_awards`.`festival_detail`;


drop table if exists `entertainment_awards`.`artwork`;
CREATE TABLE IF NOT EXISTS `entertainment_awards`.`artwork` (
    `Artwork_ID` INT,
    `Type` STRING,
    `Name` STRING,
    PRIMARY KEY (`Artwork_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entertainment_awards/data/artwork.csv' INTO TABLE `entertainment_awards`.`artwork`;


drop table if exists `entertainment_awards`.`nomination`;
CREATE TABLE IF NOT EXISTS `entertainment_awards`.`nomination` (
    `Artwork_ID` INT,
    `Festival_ID` INT,
    `Result` STRING,
    PRIMARY KEY (`Artwork_ID`, `Festival_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Festival_ID`) REFERENCES `entertainment_awards`.`festival_detail` (`Festival_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Artwork_ID`) REFERENCES `entertainment_awards`.`artwork` (`Artwork_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entertainment_awards/data/nomination.csv' INTO TABLE `entertainment_awards`.`nomination`;

