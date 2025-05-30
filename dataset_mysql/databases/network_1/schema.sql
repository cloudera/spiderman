-- Dialect: mysql | Database: network_1 | Table Count: 3

CREATE TABLE `network_1`.`Highschooler` (
    `ID` INT,
    `name` TEXT,
    `grade` INT,
    PRIMARY KEY (`ID`)
);

CREATE TABLE `network_1`.`Friend` (
    `student_id` INT,
    `friend_id` INT,
    PRIMARY KEY (`student_id`, `friend_id`),
    FOREIGN KEY (`friend_id`) REFERENCES `network_1`.`Highschooler` (`ID`),
    FOREIGN KEY (`student_id`) REFERENCES `network_1`.`Highschooler` (`ID`)
);

CREATE TABLE `network_1`.`Likes` (
    `student_id` INT,
    `liked_id` INT,
    PRIMARY KEY (`student_id`, `liked_id`),
    FOREIGN KEY (`student_id`) REFERENCES `network_1`.`Highschooler` (`ID`),
    FOREIGN KEY (`liked_id`) REFERENCES `network_1`.`Highschooler` (`ID`)
);
