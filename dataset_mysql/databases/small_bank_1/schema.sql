-- Dialect: MySQL | Database: small_bank_1 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `small_bank_1`;

DROP TABLE IF EXISTS `small_bank_1`.`ACCOUNTS`;
CREATE TABLE `small_bank_1`.`ACCOUNTS` (
    `custid` BIGINT NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    PRIMARY KEY (`custid`)
);

DROP TABLE IF EXISTS `small_bank_1`.`SAVINGS`;
CREATE TABLE `small_bank_1`.`SAVINGS` (
    `custid` BIGINT NOT NULL,
    `balance` FLOAT NOT NULL,
    PRIMARY KEY (`custid`),
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`)
);

DROP TABLE IF EXISTS `small_bank_1`.`CHECKING`;
CREATE TABLE `small_bank_1`.`CHECKING` (
    `custid` BIGINT NOT NULL,
    `balance` FLOAT NOT NULL,
    PRIMARY KEY (`custid`),
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`)
);
