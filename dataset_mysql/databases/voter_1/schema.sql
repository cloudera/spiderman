-- Dialect: MySQL | Database: voter_1 | Table Count: 3

CREATE DATABASE IF NOT EXISTS `voter_1`;

DROP TABLE IF EXISTS `voter_1`.`AREA_CODE_STATE`;
CREATE TABLE `voter_1`.`AREA_CODE_STATE` (
    `area_code` INTEGER NOT NULL,
    `state` VARCHAR(2) NOT NULL,
    PRIMARY KEY (`area_code`),
    INDEX idx_state (`state`)
);

DROP TABLE IF EXISTS `voter_1`.`CONTESTANTS`;
CREATE TABLE `voter_1`.`CONTESTANTS` (
    `contestant_number` INTEGER,
    `contestant_name` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`contestant_number`)
);

DROP TABLE IF EXISTS `voter_1`.`VOTES`;
CREATE TABLE `voter_1`.`VOTES` (
    `vote_id` INTEGER NOT NULL,
    `phone_number` VARCHAR(10) NOT NULL,
    `state` VARCHAR(2) NOT NULL,
    `contestant_number` INTEGER NOT NULL,
    `created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`vote_id`),
    FOREIGN KEY (`contestant_number`) REFERENCES `voter_1`.`CONTESTANTS` (`contestant_number`),
    INDEX idx_phone_number (`phone_number`)
);
