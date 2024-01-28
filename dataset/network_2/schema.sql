CREATE DATABASE IF NOT EXISTS `network_2`;

drop table if exists `network_2`.`Person`;
CREATE TABLE IF NOT EXISTS `network_2`.`Person` (
    `name` STRING,
    `age` INT,
    `city` STRING,
    `gender` STRING,
    `job` STRING,
    PRIMARY KEY (`name`) DISABLE NOVALIDATE
);

drop table if exists `network_2`.`PersonFriend`;
CREATE TABLE IF NOT EXISTS `network_2`.`PersonFriend` (
    `name` STRING,
    `friend` STRING,
    `year` INT,
    FOREIGN KEY (`friend`) REFERENCES `network_2`.`Person` (`name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`name`) REFERENCES `network_2`.`Person` (`name`) DISABLE NOVALIDATE
);
