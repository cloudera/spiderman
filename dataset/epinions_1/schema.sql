CREATE DATABASE IF NOT EXISTS `epinions_1`;

drop table if exists `epinions_1`.`item`;
CREATE TABLE IF NOT EXISTS `epinions_1`.`item` (
    `i_id` INT NOT NULL,
    `title` STRING,
    PRIMARY KEY (`i_id`) DISABLE NOVALIDATE
);

drop table if exists `epinions_1`.`useracct`;
CREATE TABLE IF NOT EXISTS `epinions_1`.`useracct` (
    `u_id` INT NOT NULL,
    `name` STRING,
    PRIMARY KEY (`u_id`) DISABLE NOVALIDATE
);

drop table if exists `epinions_1`.`review`;
CREATE TABLE IF NOT EXISTS `epinions_1`.`review` (
    `a_id` INT NOT NULL,
    `u_id` INT NOT NULL,
    `i_id` INT NOT NULL,
    `rating` INT,
    `rank` INT,
    PRIMARY KEY (`a_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`i_id`) REFERENCES `epinions_1`.`item` (`i_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`) DISABLE NOVALIDATE
);

drop table if exists `epinions_1`.`trust`;
CREATE TABLE IF NOT EXISTS `epinions_1`.`trust` (
    `source_u_id` INT NOT NULL,
    `target_u_id` INT NOT NULL,
    `trust` INT NOT NULL,
    FOREIGN KEY (`target_u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`source_u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`) DISABLE NOVALIDATE
);
