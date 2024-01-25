drop table if exists `riding_club`.`player`;
CREATE TABLE IF NOT EXISTS `riding_club`.`player` (
    `Player_ID` INT,
    `Sponsor_name` STRING,
    `Player_name` STRING,
    `Gender` STRING,
    `Residence` STRING,
    `Occupation` STRING,
    `Votes` INT,
    `Rank` STRING,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/player.csv' INTO TABLE `riding_club`.`player`;


drop table if exists `riding_club`.`club`;
CREATE TABLE IF NOT EXISTS `riding_club`.`club` (
    `Club_ID` INT,
    `Club_name` STRING,
    `Region` STRING,
    `Start_year` INT,
    PRIMARY KEY (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/club.csv' INTO TABLE `riding_club`.`club`;


drop table if exists `riding_club`.`coach`;
CREATE TABLE IF NOT EXISTS `riding_club`.`coach` (
    `Coach_ID` INT,
    `Coach_name` STRING,
    `Gender` STRING,
    `Club_ID` INT,
    `Rank` INT,
    PRIMARY KEY (`Coach_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `riding_club`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/coach.csv' INTO TABLE `riding_club`.`coach`;


drop table if exists `riding_club`.`player_coach`;
CREATE TABLE IF NOT EXISTS `riding_club`.`player_coach` (
    `Player_ID` INT,
    `Coach_ID` INT,
    `Starting_year` INT,
    PRIMARY KEY (`Player_ID`, `Coach_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Coach_ID`) REFERENCES `riding_club`.`coach` (`Coach_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Player_ID`) REFERENCES `riding_club`.`player` (`Player_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/player_coach.csv' INTO TABLE `riding_club`.`player_coach`;


drop table if exists `riding_club`.`match_result`;
CREATE TABLE IF NOT EXISTS `riding_club`.`match_result` (
    `Rank` INT,
    `Club_ID` INT,
    `Gold` INT,
    `Big_Silver` INT,
    `Small_Silver` INT,
    `Bronze` INT,
    `Points` INT,
    PRIMARY KEY (`Rank`, `Club_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `riding_club`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/match_result.csv' INTO TABLE `riding_club`.`match_result`;

