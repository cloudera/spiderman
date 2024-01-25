drop table if exists `music_4`.`artist`;
CREATE TABLE IF NOT EXISTS `music_4`.`artist` (
    `Artist_ID` INT,
    `Artist` STRING,
    `Age` INT,
    `Famous_Title` STRING,
    `Famous_Release_date` STRING,
    PRIMARY KEY (`Artist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_4/data/artist.csv' INTO TABLE `music_4`.`artist`;


drop table if exists `music_4`.`volume`;
CREATE TABLE IF NOT EXISTS `music_4`.`volume` (
    `Volume_ID` INT,
    `Volume_Issue` STRING,
    `Issue_Date` STRING,
    `Weeks_on_Top` REAL,
    `Song` STRING,
    `Artist_ID` INT,
    PRIMARY KEY (`Volume_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Artist_ID`) REFERENCES `music_4`.`artist` (`Artist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_4/data/volume.csv' INTO TABLE `music_4`.`volume`;


drop table if exists `music_4`.`music_festival`;
CREATE TABLE IF NOT EXISTS `music_4`.`music_festival` (
    `ID` INT,
    `Music_Festival` STRING,
    `Date_of_ceremony` STRING,
    `Category` STRING,
    `Volume` INT,
    `Result` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Volume`) REFERENCES `music_4`.`volume` (`Volume_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_4/data/music_festival.csv' INTO TABLE `music_4`.`music_festival`;

