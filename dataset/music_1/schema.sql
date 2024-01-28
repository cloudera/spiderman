CREATE DATABASE IF NOT EXISTS `music_1`;

drop table if exists `music_1`.`genre`;
CREATE TABLE IF NOT EXISTS `music_1`.`genre` (
    `g_name` STRING NOT NULL,
    `rating` STRING,
    `most_popular_in` STRING,
    PRIMARY KEY (`g_name`) DISABLE NOVALIDATE
);

drop table if exists `music_1`.`artist`;
CREATE TABLE IF NOT EXISTS `music_1`.`artist` (
    `artist_name` STRING NOT NULL,
    `country` STRING,
    `gender` STRING,
    `preferred_genre` STRING,
    PRIMARY KEY (`artist_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`preferred_genre`) REFERENCES `music_1`.`genre` (`g_name`) DISABLE NOVALIDATE
);

drop table if exists `music_1`.`files`;
CREATE TABLE IF NOT EXISTS `music_1`.`files` (
    `f_id` NUMERIC(10) NOT NULL,
    `artist_name` STRING,
    `file_size` STRING,
    `duration` STRING,
    `formats` STRING,
    PRIMARY KEY (`f_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`artist_name`) REFERENCES `music_1`.`artist` (`artist_name`) DISABLE NOVALIDATE
);

drop table if exists `music_1`.`song`;
CREATE TABLE IF NOT EXISTS `music_1`.`song` (
    `song_name` STRING,
    `artist_name` STRING,
    `country` STRING,
    `f_id` NUMERIC(10),
    `genre_is` STRING,
    `rating` NUMERIC(10),
    `languages` STRING,
    `releasedate` DATE,
    `resolution` NUMERIC(10) NOT NULL,
    PRIMARY KEY (`song_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`genre_is`) REFERENCES `music_1`.`genre` (`g_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`f_id`) REFERENCES `music_1`.`files` (`f_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`artist_name`) REFERENCES `music_1`.`artist` (`artist_name`) DISABLE NOVALIDATE
);
