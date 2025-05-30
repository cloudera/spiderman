-- Dialect: mysql | Database: soccer_1 | Table Count: 6

CREATE TABLE `soccer_1`.`Player` (
    `id` INTEGER,
    `player_api_id` INTEGER,
    `player_name` TEXT,
    `player_fifa_api_id` INTEGER,
    `birthday` TEXT,
    `height` INTEGER,
    `weight` INTEGER,
    PRIMARY KEY (`id`),
    UNIQUE (`player_api_id`),
    UNIQUE (`player_fifa_api_id`)
);

CREATE TABLE `soccer_1`.`Player_Attributes` (
    `id` INTEGER,
    `player_fifa_api_id` INTEGER,
    `player_api_id` INTEGER,
    `date` TEXT,
    `overall_rating` INTEGER,
    `potential` INTEGER,
    `preferred_foot` TEXT,
    `attacking_work_rate` TEXT,
    `defensive_work_rate` TEXT,
    `crossing` INTEGER,
    `finishing` INTEGER,
    `heading_accuracy` INTEGER,
    `short_passing` INTEGER,
    `volleys` INTEGER,
    `dribbling` INTEGER,
    `curve` INTEGER,
    `free_kick_accuracy` INTEGER,
    `long_passing` INTEGER,
    `ball_control` INTEGER,
    `acceleration` INTEGER,
    `sprint_speed` INTEGER,
    `agility` INTEGER,
    `reactions` INTEGER,
    `balance` INTEGER,
    `shot_power` INTEGER,
    `jumping` INTEGER,
    `stamina` INTEGER,
    `strength` INTEGER,
    `long_shots` INTEGER,
    `aggression` INTEGER,
    `interceptions` INTEGER,
    `positioning` INTEGER,
    `vision` INTEGER,
    `penalties` INTEGER,
    `marking` INTEGER,
    `standing_tackle` INTEGER,
    `sliding_tackle` INTEGER,
    `gk_diving` INTEGER,
    `gk_handling` INTEGER,
    `gk_kicking` INTEGER,
    `gk_positioning` INTEGER,
    `gk_reflexes` INTEGER,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`player_api_id`) REFERENCES `soccer_1`.`Player` (`player_api_id`),
    FOREIGN KEY (`player_fifa_api_id`) REFERENCES `soccer_1`.`Player` (`player_fifa_api_id`)
);

CREATE TABLE `soccer_1`.`Country` (
    `id` INTEGER,
    `name` VARCHAR(50),
    PRIMARY KEY (`id`),
    UNIQUE (`name`)
);

CREATE TABLE `soccer_1`.`League` (
    `id` INTEGER,
    `country_id` INTEGER,
    `name` VARCHAR(50),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`country_id`) REFERENCES `soccer_1`.`Country` (`id`),
    UNIQUE (`name`)
);

CREATE TABLE `soccer_1`.`Team` (
    `id` INTEGER,
    `team_api_id` INTEGER,
    `team_fifa_api_id` INTEGER,
    `team_long_name` TEXT,
    `team_short_name` TEXT,
    PRIMARY KEY (`id`),
    UNIQUE (`team_api_id`),
    INDEX idx_team_fifa_api_id (`team_fifa_api_id`)
);

CREATE TABLE `soccer_1`.`Team_Attributes` (
    `id` INTEGER,
    `team_fifa_api_id` INTEGER,
    `team_api_id` INTEGER,
    `date` TEXT,
    `buildUpPlaySpeed` INTEGER,
    `buildUpPlaySpeedClass` TEXT,
    `buildUpPlayDribbling` INTEGER,
    `buildUpPlayDribblingClass` TEXT,
    `buildUpPlayPassing` INTEGER,
    `buildUpPlayPassingClass` TEXT,
    `buildUpPlayPositioningClass` TEXT,
    `chanceCreationPassing` INTEGER,
    `chanceCreationPassingClass` TEXT,
    `chanceCreationCrossing` INTEGER,
    `chanceCreationCrossingClass` TEXT,
    `chanceCreationShooting` INTEGER,
    `chanceCreationShootingClass` TEXT,
    `chanceCreationPositioningClass` TEXT,
    `defencePressure` INTEGER,
    `defencePressureClass` TEXT,
    `defenceAggression` INTEGER,
    `defenceAggressionClass` TEXT,
    `defenceTeamWidth` INTEGER,
    `defenceTeamWidthClass` TEXT,
    `defenceDefenderLineClass` TEXT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`team_api_id`) REFERENCES `soccer_1`.`Team` (`team_api_id`)
);
