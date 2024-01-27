CREATE DATABASE IF NOT EXISTS `party_people`;

drop table if exists `party_people`.`region`;
CREATE TABLE IF NOT EXISTS `party_people`.`region` (
    `Region_ID` INT,
    `Region_name` STRING,
    `Date` STRING,
    `Label` STRING,
    `Format` STRING,
    `Catalogue` STRING,
    PRIMARY KEY (`Region_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_people/data/region.csv' INTO TABLE `party_people`.`region`;


drop table if exists `party_people`.`party`;
CREATE TABLE IF NOT EXISTS `party_people`.`party` (
    `Party_ID` INT,
    `Minister` STRING,
    `Took_office` STRING,
    `Left_office` STRING,
    `Region_ID` INT,
    `Party_name` STRING,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Region_ID`) REFERENCES `party_people`.`region` (`Region_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_people/data/party.csv' INTO TABLE `party_people`.`party`;


drop table if exists `party_people`.`member`;
CREATE TABLE IF NOT EXISTS `party_people`.`member` (
    `Member_ID` INT,
    `Member_Name` STRING,
    `Party_ID` INT,
    `In_office` STRING,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party_ID`) REFERENCES `party_people`.`party` (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_people/data/member.csv' INTO TABLE `party_people`.`member`;


drop table if exists `party_people`.`party_events`;
CREATE TABLE IF NOT EXISTS `party_people`.`party_events` (
    `Event_ID` INT,
    `Event_Name` STRING,
    `Party_ID` INT,
    `Member_in_charge_ID` INT,
    PRIMARY KEY (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_in_charge_ID`) REFERENCES `party_people`.`member` (`Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party_ID`) REFERENCES `party_people`.`party` (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_people/data/party_events.csv' INTO TABLE `party_people`.`party_events`;

