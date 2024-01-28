CREATE DATABASE IF NOT EXISTS `wta_1`;

drop table if exists `wta_1`.`players`;
CREATE TABLE IF NOT EXISTS `wta_1`.`players` (
    `player_id` INT,
    `first_name` STRING,
    `last_name` STRING,
    `hand` STRING,
    `birth_date` DATE,
    `country_code` STRING,
    PRIMARY KEY (`player_id`) DISABLE NOVALIDATE
);

drop table if exists `wta_1`.`matches`;
CREATE TABLE IF NOT EXISTS `wta_1`.`matches` (
    `best_of` INT,
    `draw_size` INT,
    `loser_age` DECIMAL,
    `loser_entry` STRING,
    `loser_hand` STRING,
    `loser_ht` INT,
    `loser_id` INT,
    `loser_ioc` STRING,
    `loser_name` STRING,
    `loser_rank` INT,
    `loser_rank_points` INT,
    `loser_seed` INT,
    `match_num` INT,
    `minutes` INT,
    `round` STRING,
    `score` STRING,
    `surface` STRING,
    `tourney_date` DATE,
    `tourney_id` STRING,
    `tourney_level` STRING,
    `tourney_name` STRING,
    `winner_age` DECIMAL,
    `winner_entry` STRING,
    `winner_hand` STRING,
    `winner_ht` INT,
    `winner_id` INT,
    `winner_ioc` STRING,
    `winner_name` STRING,
    `winner_rank` INT,
    `winner_rank_points` INT,
    `winner_seed` INT,
    `year` INT,
    FOREIGN KEY (`winner_id`) REFERENCES `wta_1`.`players` (`player_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`loser_id`) REFERENCES `wta_1`.`players` (`player_id`) DISABLE NOVALIDATE
);

drop table if exists `wta_1`.`rankings`;
CREATE TABLE IF NOT EXISTS `wta_1`.`rankings` (
    `ranking_date` DATE,
    `ranking` INT,
    `player_id` INT,
    `ranking_points` INT,
    `tours` INT,
    FOREIGN KEY (`player_id`) REFERENCES `wta_1`.`players` (`player_id`) DISABLE NOVALIDATE
);
