-- Dialect: mysql | Database: match_season | Table Count: 4

CREATE TABLE `match_season`.`country` (
    `Country_id` INT,
    `Country_name` TEXT,
    `Capital` TEXT,
    `Official_native_language` TEXT,
    PRIMARY KEY (`Country_id`)
);

CREATE TABLE `match_season`.`team` (
    `Team_id` INT,
    `Name` TEXT,
    PRIMARY KEY (`Team_id`)
);

CREATE TABLE `match_season`.`match_season` (
    `Season` REAL,
    `Player` TEXT,
    `Position` TEXT,
    `Country` INT,
    `Team` INT,
    `Draft_Pick_Number` INT,
    `Draft_Class` TEXT,
    `College` TEXT,
    PRIMARY KEY (`Season`),
    FOREIGN KEY (`Team`) REFERENCES `match_season`.`team` (`Team_id`),
    FOREIGN KEY (`Country`) REFERENCES `match_season`.`country` (`Country_id`)
);

CREATE TABLE `match_season`.`player` (
    `Player_ID` INT,
    `Player` TEXT,
    `Years_Played` TEXT,
    `Total_WL` TEXT,
    `Singles_WL` TEXT,
    `Doubles_WL` TEXT,
    `Team` INT,
    PRIMARY KEY (`Player_ID`),
    FOREIGN KEY (`Team`) REFERENCES `match_season`.`team` (`Team_id`)
);
