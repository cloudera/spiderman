-- Dialect: MySQL | Database: wta_1 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `wta_1`;

DROP TABLE IF EXISTS `wta_1`.`players`;
CREATE TABLE `wta_1`.`players` (
    `player_id` INT,
    `first_name` TEXT,
    `last_name` TEXT,
    `hand` TEXT,
    `birth_date` DATE,
    `country_code` TEXT,
    PRIMARY KEY (`player_id`)
);

DROP TABLE IF EXISTS `wta_1`.`matches`;
CREATE TABLE `wta_1`.`matches` (
    `best_of` INT,
    `draw_size` INT,
    `loser_age` FLOAT,
    `loser_entry` TEXT,
    `loser_hand` TEXT,
    `loser_ht` INT,
    `loser_id` INT,
    `loser_ioc` TEXT,
    `loser_name` TEXT,
    `loser_rank` INT,
    `loser_rank_points` INT,
    `loser_seed` INT,
    `match_num` INT,
    `minutes` INT,
    `round` TEXT,
    `score` TEXT,
    `surface` TEXT,
    `tourney_date` DATE,
    `tourney_id` TEXT,
    `tourney_level` TEXT,
    `tourney_name` TEXT,
    `winner_age` FLOAT,
    `winner_entry` TEXT,
    `winner_hand` TEXT,
    `winner_ht` INT,
    `winner_id` INT,
    `winner_ioc` TEXT,
    `winner_name` TEXT,
    `winner_rank` INT,
    `winner_rank_points` INT,
    `winner_seed` INT,
    `year` INT,
    FOREIGN KEY (`winner_id`) REFERENCES `wta_1`.`players` (`player_id`),
    FOREIGN KEY (`loser_id`) REFERENCES `wta_1`.`players` (`player_id`)
);

DROP TABLE IF EXISTS `wta_1`.`rankings`;
CREATE TABLE `wta_1`.`rankings` (
    `ranking_date` DATE,
    `ranking` INT,
    `player_id` INT,
    `ranking_points` INT,
    `tours` INT,
    FOREIGN KEY (`player_id`) REFERENCES `wta_1`.`players` (`player_id`)
);
