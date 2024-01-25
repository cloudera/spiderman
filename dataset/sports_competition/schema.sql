drop table if exists `sports_competition`.`club`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`club` (
    `Club_ID` INT,
    `name` STRING,
    `Region` STRING,
    `Start_year` STRING,
    PRIMARY KEY (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/club.csv' INTO TABLE `sports_competition`.`club`;


drop table if exists `sports_competition`.`club_rank`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`club_rank` (
    `Rank` REAL,
    `Club_ID` INT,
    `Gold` REAL,
    `Silver` REAL,
    `Bronze` REAL,
    `Total` REAL,
    PRIMARY KEY (`Rank`, `Club_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/club_rank.csv' INTO TABLE `sports_competition`.`club_rank`;


drop table if exists `sports_competition`.`player`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`player` (
    `Player_ID` INT,
    `name` STRING,
    `Position` STRING,
    `Club_ID` INT,
    `Apps` REAL,
    `Tries` REAL,
    `Goals` STRING,
    `Points` REAL,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/player.csv' INTO TABLE `sports_competition`.`player`;


drop table if exists `sports_competition`.`competition`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`competition` (
    `Competition_ID` INT,
    `Year` REAL,
    `Competition_type` STRING,
    `Country` STRING,
    PRIMARY KEY (`Competition_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/competition.csv' INTO TABLE `sports_competition`.`competition`;


drop table if exists `sports_competition`.`competition_result`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`competition_result` (
    `Competition_ID` INT,
    `Club_ID_1` INT,
    `Club_ID_2` INT,
    `Score` STRING,
    PRIMARY KEY (`Competition_ID`, `Club_ID_1`, `Club_ID_2`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Competition_ID`) REFERENCES `sports_competition`.`competition` (`Competition_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID_2`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID_1`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/competition_result.csv' INTO TABLE `sports_competition`.`competition_result`;

