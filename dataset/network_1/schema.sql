CREATE DATABASE IF NOT EXISTS `network_1`;

drop table if exists `network_1`.`Highschooler`;
CREATE TABLE IF NOT EXISTS `network_1`.`Highschooler` (
    `ID` INT,
    `name` STRING,
    `grade` INT,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_1/data/Highschooler.csv' INTO TABLE `network_1`.`Highschooler`;


drop table if exists `network_1`.`Friend`;
CREATE TABLE IF NOT EXISTS `network_1`.`Friend` (
    `student_id` INT,
    `friend_id` INT,
    PRIMARY KEY (`student_id`, `friend_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`friend_id`) REFERENCES `network_1`.`Highschooler` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `network_1`.`Highschooler` (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_1/data/Friend.csv' INTO TABLE `network_1`.`Friend`;


drop table if exists `network_1`.`Likes`;
CREATE TABLE IF NOT EXISTS `network_1`.`Likes` (
    `student_id` INT,
    `liked_id` INT,
    PRIMARY KEY (`student_id`, `liked_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `network_1`.`Highschooler` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`liked_id`) REFERENCES `network_1`.`Highschooler` (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_1/data/Likes.csv' INTO TABLE `network_1`.`Likes`;

