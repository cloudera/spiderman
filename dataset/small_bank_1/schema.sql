drop table if exists `small_bank_1`.`ACCOUNTS`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`ACCOUNTS` (
    `custid` BIGINT NOT NULL,
    `name` STRING NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/small_bank_1/data/ACCOUNTS.csv' INTO TABLE `small_bank_1`.`ACCOUNTS`;


drop table if exists `small_bank_1`.`SAVINGS`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`SAVINGS` (
    `custid` BIGINT NOT NULL,
    `balance` DECIMAL NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/small_bank_1/data/SAVINGS.csv' INTO TABLE `small_bank_1`.`SAVINGS`;


drop table if exists `small_bank_1`.`CHECKING`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`CHECKING` (
    `custid` BIGINT NOT NULL,
    `balance` DECIMAL NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/small_bank_1/data/CHECKING.csv' INTO TABLE `small_bank_1`.`CHECKING`;

