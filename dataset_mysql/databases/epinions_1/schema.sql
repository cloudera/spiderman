-- Dialect: mysql | Database: epinions_1 | Table Count: 4

CREATE TABLE `epinions_1`.`item` (
    `i_id` INTEGER NOT NULL,
    `title` VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (`i_id`)
);

CREATE TABLE `epinions_1`.`useracct` (
    `u_id` INTEGER NOT NULL,
    `name` VARCHAR(128) DEFAULT NULL,
    PRIMARY KEY (`u_id`)
);

CREATE TABLE `epinions_1`.`review` (
    `a_id` INTEGER NOT NULL,
    `u_id` INTEGER NOT NULL,
    `i_id` INTEGER NOT NULL,
    `rating` INTEGER DEFAULT NULL,
    `rank` INTEGER DEFAULT NULL,
    PRIMARY KEY (`a_id`),
    FOREIGN KEY (`i_id`) REFERENCES `epinions_1`.`item` (`i_id`),
    FOREIGN KEY (`u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`),
    INDEX idx_a_id (`a_id`),
    INDEX idx_u_id (`u_id`),
    INDEX idx_i_id (`i_id`)
);

CREATE TABLE `epinions_1`.`trust` (
    `source_u_id` INTEGER NOT NULL,
    `target_u_id` INTEGER NOT NULL,
    `trust` INTEGER NOT NULL,
    FOREIGN KEY (`target_u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`),
    FOREIGN KEY (`source_u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`),
    INDEX idx_source_u_id (`source_u_id`),
    INDEX idx_target_u_id (`target_u_id`)
);
