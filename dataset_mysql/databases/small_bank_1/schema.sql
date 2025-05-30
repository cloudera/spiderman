-- Dialect: mysql | Database: small_bank_1 | Table Count: 3

CREATE TABLE `small_bank_1`.`ACCOUNTS` (
    `custid` BIGINT NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    PRIMARY KEY (`custid`)
);

CREATE TABLE `small_bank_1`.`SAVINGS` (
    `custid` BIGINT NOT NULL,
    `balance` FLOAT NOT NULL,
    PRIMARY KEY (`custid`),
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`)
);

CREATE TABLE `small_bank_1`.`CHECKING` (
    `custid` BIGINT NOT NULL,
    `balance` FLOAT NOT NULL,
    PRIMARY KEY (`custid`),
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`)
);
