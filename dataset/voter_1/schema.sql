drop table if exists `voter_1`.`AREA_CODE_STATE`;
CREATE TABLE IF NOT EXISTS `voter_1`.`AREA_CODE_STATE` (
    `area_code` INT NOT NULL,
    `state` STRING NOT NULL,
    PRIMARY KEY (`area_code`) DISABLE NOVALIDATE,
    UNIQUE (`state`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_1/data/AREA_CODE_STATE.csv' INTO TABLE `voter_1`.`AREA_CODE_STATE`;


drop table if exists `voter_1`.`CONTESTANTS`;
CREATE TABLE IF NOT EXISTS `voter_1`.`CONTESTANTS` (
    `contestant_number` INT,
    `contestant_name` STRING NOT NULL,
    PRIMARY KEY (`contestant_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_1/data/CONTESTANTS.csv' INTO TABLE `voter_1`.`CONTESTANTS`;


drop table if exists `voter_1`.`VOTES`;
CREATE TABLE IF NOT EXISTS `voter_1`.`VOTES` (
    `vote_id` INT NOT NULL,
    `phone_number` INT NOT NULL,
    `state` STRING NOT NULL,
    `contestant_number` INT NOT NULL,
    `created` TIMESTAMP NOT NULL,
    PRIMARY KEY (`vote_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`contestant_number`) REFERENCES `voter_1`.`CONTESTANTS` (`contestant_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`state`) REFERENCES `voter_1`.`AREA_CODE_STATE` (`state`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_1/data/VOTES.csv' INTO TABLE `voter_1`.`VOTES`;

