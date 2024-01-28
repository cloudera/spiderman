CREATE DATABASE IF NOT EXISTS `small_bank_1`;

drop table if exists `small_bank_1`.`ACCOUNTS`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`ACCOUNTS` (
    `custid` BIGINT NOT NULL,
    `name` STRING NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE
);

drop table if exists `small_bank_1`.`SAVINGS`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`SAVINGS` (
    `custid` BIGINT NOT NULL,
    `balance` DECIMAL NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`) DISABLE NOVALIDATE
);

drop table if exists `small_bank_1`.`CHECKING`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`CHECKING` (
    `custid` BIGINT NOT NULL,
    `balance` DECIMAL NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`) DISABLE NOVALIDATE
);
