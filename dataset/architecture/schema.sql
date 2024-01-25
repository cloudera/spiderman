drop table if exists `architecture`.`architect`;
CREATE TABLE IF NOT EXISTS `architecture`.`architect` (
    `id` INT,
    `name` STRING,
    `nationality` STRING,
    `gender` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/architecture/data/architect.csv' INTO TABLE `architecture`.`architect`;


drop table if exists `architecture`.`bridge`;
CREATE TABLE IF NOT EXISTS `architecture`.`bridge` (
    `architect_id` INT,
    `id` INT,
    `name` STRING,
    `location` STRING,
    `length_meters` REAL,
    `length_feet` REAL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`architect_id`) REFERENCES `architecture`.`architect` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/architecture/data/bridge.csv' INTO TABLE `architecture`.`bridge`;


drop table if exists `architecture`.`mill`;
CREATE TABLE IF NOT EXISTS `architecture`.`mill` (
    `architect_id` INT,
    `id` INT,
    `location` STRING,
    `name` STRING,
    `type` STRING,
    `built_year` INT,
    `notes` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`architect_id`) REFERENCES `architecture`.`architect` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/architecture/data/mill.csv' INTO TABLE `architecture`.`mill`;

