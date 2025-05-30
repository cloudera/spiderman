-- Dialect: mysql | Database: twitter_1 | Table Count: 3

CREATE TABLE `twitter_1`.`user_profiles` (
    `uid` INT(11) NOT NULL,
    `name` VARCHAR(255) DEFAULT NULL,
    `email` VARCHAR(255) DEFAULT NULL,
    `partitionid` INT(11) DEFAULT NULL,
    `followers` INT(11) DEFAULT NULL,
    PRIMARY KEY (`uid`)
);

CREATE TABLE `twitter_1`.`follows` (
    `f1` INT(11) NOT NULL,
    `f2` INT(11) NOT NULL,
    PRIMARY KEY (`f1`, `f2`),
    FOREIGN KEY (`f2`) REFERENCES `twitter_1`.`user_profiles` (`uid`),
    FOREIGN KEY (`f1`) REFERENCES `twitter_1`.`user_profiles` (`uid`)
);

CREATE TABLE `twitter_1`.`tweets` (
    `id` BIGINT(20) NOT NULL,
    `uid` INT(11) NOT NULL,
    `text` CHAR(140) NOT NULL,
    `createdate` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`uid`) REFERENCES `twitter_1`.`user_profiles` (`uid`)
);
