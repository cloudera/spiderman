drop table if exists `network_2`.`Person`;
CREATE TABLE IF NOT EXISTS `network_2`.`Person` (
    `name` STRING,
    `age` INT,
    `city` STRING,
    `gender` STRING,
    `job` STRING,
    PRIMARY KEY (`name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_2/data/Person.csv' INTO TABLE `network_2`.`Person`;


drop table if exists `network_2`.`PersonFriend`;
CREATE TABLE IF NOT EXISTS `network_2`.`PersonFriend` (
    `name` STRING,
    `friend` STRING,
    `year` INT,
    FOREIGN KEY (`friend`) REFERENCES `network_2`.`Person` (`name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`name`) REFERENCES `network_2`.`Person` (`name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_2/data/PersonFriend.csv' INTO TABLE `network_2`.`PersonFriend`;

