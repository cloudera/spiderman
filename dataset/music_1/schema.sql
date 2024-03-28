-- Dialect: MySQL | Database: music_1 | Table Count: 4

CREATE DATABASE IF NOT EXISTS `music_1`;

DROP TABLE IF EXISTS `music_1`.`genre`;
CREATE TABLE `music_1`.`genre` (
    `g_name` VARCHAR(20) NOT NULL,
    `rating` VARCHAR(10),
    `most_popular_in` VARCHAR(50),
    PRIMARY KEY (`g_name`)
);

DROP TABLE IF EXISTS `music_1`.`artist`;
CREATE TABLE `music_1`.`artist` (
    `artist_name` VARCHAR(50) NOT NULL,
    `country` VARCHAR(20),
    `gender` VARCHAR(20),
    `preferred_genre` VARCHAR(50),
    PRIMARY KEY (`artist_name`),
    FOREIGN KEY (`preferred_genre`) REFERENCES `music_1`.`genre` (`g_name`)
);

DROP TABLE IF EXISTS `music_1`.`files`;
CREATE TABLE `music_1`.`files` (
    `f_id` NUMERIC(10) NOT NULL,
    `artist_name` VARCHAR(50),
    `file_size` VARCHAR(20),
    `duration` VARCHAR(20),
    `formats` VARCHAR(20),
    PRIMARY KEY (`f_id`),
    FOREIGN KEY (`artist_name`) REFERENCES `music_1`.`artist` (`artist_name`)
);

DROP TABLE IF EXISTS `music_1`.`song`;
CREATE TABLE `music_1`.`song` (
    `song_name` VARCHAR(50),
    `artist_name` VARCHAR(50),
    `country` VARCHAR(20),
    `f_id` NUMERIC(10),
    `genre_is` VARCHAR(20),
    `rating` NUMERIC(10),
    `languages` VARCHAR(20),
    `releasedate` DATE,
    `resolution` NUMERIC(10) NOT NULL,
    PRIMARY KEY (`song_name`),
    FOREIGN KEY (`genre_is`) REFERENCES `music_1`.`genre` (`g_name`),
    FOREIGN KEY (`f_id`) REFERENCES `music_1`.`files` (`f_id`),
    FOREIGN KEY (`artist_name`) REFERENCES `music_1`.`artist` (`artist_name`)
);
