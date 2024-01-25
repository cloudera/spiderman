drop table if exists `theme_gallery`.`artist`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`artist` (
    `Artist_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Year_Join` INT,
    `Age` INT,
    PRIMARY KEY (`Artist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/theme_gallery/data/artist.csv' INTO TABLE `theme_gallery`.`artist`;


drop table if exists `theme_gallery`.`exhibition`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`exhibition` (
    `Exhibition_ID` INT,
    `Year` INT,
    `Theme` STRING,
    `Artist_ID` INT,
    `Ticket_Price` REAL,
    PRIMARY KEY (`Exhibition_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Artist_ID`) REFERENCES `theme_gallery`.`artist` (`Artist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/theme_gallery/data/exhibition.csv' INTO TABLE `theme_gallery`.`exhibition`;


drop table if exists `theme_gallery`.`exhibition_record`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`exhibition_record` (
    `Exhibition_ID` INT,
    `Date` STRING,
    `Attendance` INT,
    PRIMARY KEY (`Exhibition_ID`, `Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Exhibition_ID`) REFERENCES `theme_gallery`.`exhibition` (`Exhibition_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/theme_gallery/data/exhibition_record.csv' INTO TABLE `theme_gallery`.`exhibition_record`;

