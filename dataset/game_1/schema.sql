drop table if exists `game_1`.`Student`;
CREATE TABLE IF NOT EXISTS `game_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_1/data/Student.csv' INTO TABLE `game_1`.`Student`;


drop table if exists `game_1`.`Video_Games`;
CREATE TABLE IF NOT EXISTS `game_1`.`Video_Games` (
    `GameID` INT,
    `GName` STRING,
    `GType` STRING,
    PRIMARY KEY (`GameID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_1/data/Video_Games.csv' INTO TABLE `game_1`.`Video_Games`;


drop table if exists `game_1`.`Plays_Games`;
CREATE TABLE IF NOT EXISTS `game_1`.`Plays_Games` (
    `StuID` INT,
    `GameID` INT,
    `Hours_Played` INT,
    FOREIGN KEY (`StuID`) REFERENCES `game_1`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`GameID`) REFERENCES `game_1`.`Video_Games` (`GameID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_1/data/Plays_Games.csv' INTO TABLE `game_1`.`Plays_Games`;


drop table if exists `game_1`.`SportsInfo`;
CREATE TABLE IF NOT EXISTS `game_1`.`SportsInfo` (
    `StuID` INT,
    `SportName` STRING,
    `HoursPerWeek` INT,
    `GamesPlayed` INT,
    `OnScholarship` STRING,
    FOREIGN KEY (`StuID`) REFERENCES `game_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_1/data/SportsInfo.csv' INTO TABLE `game_1`.`SportsInfo`;

