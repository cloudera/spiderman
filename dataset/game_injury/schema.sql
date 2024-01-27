CREATE DATABASE IF NOT EXISTS `game_injury`;

drop table if exists `game_injury`.`stadium`;
CREATE TABLE IF NOT EXISTS `game_injury`.`stadium` (
    `id` INT,
    `name` STRING,
    `Home_Games` INT,
    `Average_Attendance` REAL,
    `Total_Attendance` REAL,
    `Capacity_Percentage` REAL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_injury/data/stadium.csv' INTO TABLE `game_injury`.`stadium`;


drop table if exists `game_injury`.`game`;
CREATE TABLE IF NOT EXISTS `game_injury`.`game` (
    `stadium_id` INT,
    `id` INT,
    `Season` INT,
    `Date` STRING,
    `Home_team` STRING,
    `Away_team` STRING,
    `Score` STRING,
    `Competition` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`stadium_id`) REFERENCES `game_injury`.`stadium` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_injury/data/game.csv' INTO TABLE `game_injury`.`game`;


drop table if exists `game_injury`.`injury_accident`;
CREATE TABLE IF NOT EXISTS `game_injury`.`injury_accident` (
    `game_id` INT,
    `id` INT,
    `Player` STRING,
    `Injury` STRING,
    `Number_of_matches` STRING,
    `Source` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`game_id`) REFERENCES `game_injury`.`game` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_injury/data/injury_accident.csv' INTO TABLE `game_injury`.`injury_accident`;

