CREATE DATABASE IF NOT EXISTS `party_host`;

drop table if exists `party_host`.`party`;
CREATE TABLE IF NOT EXISTS `party_host`.`party` (
    `Party_ID` INT,
    `Party_Theme` STRING,
    `Location` STRING,
    `First_year` STRING,
    `Last_year` STRING,
    `Number_of_hosts` INT,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_host/data/party.csv' INTO TABLE `party_host`.`party`;


drop table if exists `party_host`.`host`;
CREATE TABLE IF NOT EXISTS `party_host`.`host` (
    `Host_ID` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Age` STRING,
    PRIMARY KEY (`Host_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_host/data/host.csv' INTO TABLE `party_host`.`host`;


drop table if exists `party_host`.`party_host`;
CREATE TABLE IF NOT EXISTS `party_host`.`party_host` (
    `Party_ID` INT,
    `Host_ID` INT,
    `Is_Main_in_Charge` BOOLEAN,
    PRIMARY KEY (`Party_ID`, `Host_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party_ID`) REFERENCES `party_host`.`party` (`Party_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Host_ID`) REFERENCES `party_host`.`host` (`Host_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_host/data/party_host.csv' INTO TABLE `party_host`.`party_host`;

