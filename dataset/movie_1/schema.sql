CREATE DATABASE IF NOT EXISTS `movie_1`;

drop table if exists `movie_1`.`Movie`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Movie` (
    `mID` INT,
    `title` STRING,
    `year` INT,
    `director` STRING,
    PRIMARY KEY (`mID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/movie_1/data/Movie.csv' INTO TABLE `movie_1`.`Movie`;


drop table if exists `movie_1`.`Reviewer`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Reviewer` (
    `rID` INT,
    `name` STRING,
    PRIMARY KEY (`rID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/movie_1/data/Reviewer.csv' INTO TABLE `movie_1`.`Reviewer`;


drop table if exists `movie_1`.`Rating`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Rating` (
    `rID` INT,
    `mID` INT,
    `stars` INT,
    `ratingDate` DATE,
    FOREIGN KEY (`rID`) REFERENCES `movie_1`.`Reviewer` (`rID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`mID`) REFERENCES `movie_1`.`Movie` (`mID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/movie_1/data/Rating.csv' INTO TABLE `movie_1`.`Rating`;

