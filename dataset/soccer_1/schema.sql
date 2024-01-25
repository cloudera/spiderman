drop table if exists `soccer_1`.`Player`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Player` (
    `id` INT,
    `player_api_id` INT,
    `player_name` STRING,
    `player_fifa_api_id` INT,
    `birthday` STRING,
    `height` INT,
    `weight` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    UNIQUE (`player_fifa_api_id`) DISABLE NOVALIDATE,
    UNIQUE (`player_api_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Player.csv' INTO TABLE `soccer_1`.`Player`;


drop table if exists `soccer_1`.`Player_Attributes`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Player_Attributes` (
    `id` INT,
    `player_fifa_api_id` INT,
    `player_api_id` INT,
    `date` STRING,
    `overall_rating` INT,
    `potential` INT,
    `preferred_foot` STRING,
    `attacking_work_rate` STRING,
    `defensive_work_rate` STRING,
    `crossing` INT,
    `finishing` INT,
    `heading_accuracy` INT,
    `short_passing` INT,
    `volleys` INT,
    `dribbling` INT,
    `curve` INT,
    `free_kick_accuracy` INT,
    `long_passing` INT,
    `ball_control` INT,
    `acceleration` INT,
    `sprint_speed` INT,
    `agility` INT,
    `reactions` INT,
    `balance` INT,
    `shot_power` INT,
    `jumping` INT,
    `stamina` INT,
    `strength` INT,
    `long_shots` INT,
    `aggression` INT,
    `interceptions` INT,
    `positioning` INT,
    `vision` INT,
    `penalties` INT,
    `marking` INT,
    `standing_tackle` INT,
    `sliding_tackle` INT,
    `gk_diving` INT,
    `gk_handling` INT,
    `gk_kicking` INT,
    `gk_positioning` INT,
    `gk_reflexes` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_api_id`) REFERENCES `soccer_1`.`Player` (`player_api_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_fifa_api_id`) REFERENCES `soccer_1`.`Player` (`player_fifa_api_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Player_Attributes.csv' INTO TABLE `soccer_1`.`Player_Attributes`;


drop table if exists `soccer_1`.`Country`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Country` (
    `id` INT,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    UNIQUE (`name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Country.csv' INTO TABLE `soccer_1`.`Country`;


drop table if exists `soccer_1`.`League`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`League` (
    `id` INT,
    `country_id` INT,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`country_id`) REFERENCES `soccer_1`.`Country` (`id`) DISABLE NOVALIDATE,
    UNIQUE (`name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/League.csv' INTO TABLE `soccer_1`.`League`;


drop table if exists `soccer_1`.`Team`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Team` (
    `id` INT,
    `team_api_id` INT,
    `team_fifa_api_id` INT,
    `team_long_name` STRING,
    `team_short_name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    UNIQUE (`team_api_id`) DISABLE NOVALIDATE,
    UNIQUE (`team_fifa_api_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Team.csv' INTO TABLE `soccer_1`.`Team`;


drop table if exists `soccer_1`.`Team_Attributes`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Team_Attributes` (
    `id` INT,
    `team_fifa_api_id` INT,
    `team_api_id` INT,
    `date` STRING,
    `buildUpPlaySpeed` INT,
    `buildUpPlaySpeedClass` STRING,
    `buildUpPlayDribbling` INT,
    `buildUpPlayDribblingClass` STRING,
    `buildUpPlayPassing` INT,
    `buildUpPlayPassingClass` STRING,
    `buildUpPlayPositioningClass` STRING,
    `chanceCreationPassing` INT,
    `chanceCreationPassingClass` STRING,
    `chanceCreationCrossing` INT,
    `chanceCreationCrossingClass` STRING,
    `chanceCreationShooting` INT,
    `chanceCreationShootingClass` STRING,
    `chanceCreationPositioningClass` STRING,
    `defencePressure` INT,
    `defencePressureClass` STRING,
    `defenceAggression` INT,
    `defenceAggressionClass` STRING,
    `defenceTeamWidth` INT,
    `defenceTeamWidthClass` STRING,
    `defenceDefenderLineClass` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`team_api_id`) REFERENCES `soccer_1`.`Team` (`team_api_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`team_fifa_api_id`) REFERENCES `soccer_1`.`Team` (`team_fifa_api_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Team_Attributes.csv' INTO TABLE `soccer_1`.`Team_Attributes`;

