-- Dialect: mysql | Database: network_2 | Table Count: 2

CREATE TABLE `network_2`.`Person` (
    `name` VARCHAR(20),
    `age` INTEGER,
    `city` TEXT,
    `gender` TEXT,
    `job` TEXT,
    PRIMARY KEY (`name`)
);

CREATE TABLE `network_2`.`PersonFriend` (
    `name` VARCHAR(20),
    `friend` VARCHAR(20),
    `year` INTEGER,
    FOREIGN KEY (`friend`) REFERENCES `network_2`.`Person` (`name`),
    FOREIGN KEY (`name`) REFERENCES `network_2`.`Person` (`name`)
);
