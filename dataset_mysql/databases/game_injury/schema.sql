-- Dialect: mysql | Database: game_injury | Table Count: 3

CREATE TABLE `game_injury`.`stadium` (
    `id` INT,
    `name` TEXT,
    `Home_Games` INT,
    `Average_Attendance` REAL,
    `Total_Attendance` REAL,
    `Capacity_Percentage` REAL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `game_injury`.`game` (
    `stadium_id` INT,
    `id` INT,
    `Season` INT,
    `Date` TEXT,
    `Home_team` TEXT,
    `Away_team` TEXT,
    `Score` TEXT,
    `Competition` TEXT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`stadium_id`) REFERENCES `game_injury`.`stadium` (`id`)
);

CREATE TABLE `game_injury`.`injury_accident` (
    `game_id` INT,
    `id` INT,
    `Player` TEXT,
    `Injury` TEXT,
    `Number_of_matches` TEXT,
    `Source` TEXT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`game_id`) REFERENCES `game_injury`.`game` (`id`)
);
