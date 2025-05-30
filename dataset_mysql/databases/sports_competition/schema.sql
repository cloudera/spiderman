-- Dialect: mysql | Database: sports_competition | Table Count: 5

CREATE TABLE `sports_competition`.`club` (
    `Club_ID` INT,
    `name` TEXT,
    `Region` TEXT,
    `Start_year` TEXT,
    PRIMARY KEY (`Club_ID`)
);

CREATE TABLE `sports_competition`.`club_rank` (
    `Rank` REAL,
    `Club_ID` INT,
    `Gold` REAL,
    `Silver` REAL,
    `Bronze` REAL,
    `Total` REAL,
    PRIMARY KEY (`Rank`, `Club_ID`),
    FOREIGN KEY (`Club_ID`) REFERENCES `sports_competition`.`club` (`Club_ID`)
);

CREATE TABLE `sports_competition`.`player` (
    `Player_ID` INT,
    `name` TEXT,
    `Position` TEXT,
    `Club_ID` INT,
    `Apps` REAL,
    `Tries` REAL,
    `Goals` TEXT,
    `Points` REAL,
    PRIMARY KEY (`Player_ID`),
    FOREIGN KEY (`Club_ID`) REFERENCES `sports_competition`.`club` (`Club_ID`)
);

CREATE TABLE `sports_competition`.`competition` (
    `Competition_ID` INT,
    `Year` REAL,
    `Competition_type` TEXT,
    `Country` TEXT,
    PRIMARY KEY (`Competition_ID`)
);

CREATE TABLE `sports_competition`.`competition_result` (
    `Competition_ID` INT,
    `Club_ID_1` INT,
    `Club_ID_2` INT,
    `Score` TEXT,
    PRIMARY KEY (`Competition_ID`, `Club_ID_1`, `Club_ID_2`),
    FOREIGN KEY (`Competition_ID`) REFERENCES `sports_competition`.`competition` (`Competition_ID`),
    FOREIGN KEY (`Club_ID_2`) REFERENCES `sports_competition`.`club` (`Club_ID`),
    FOREIGN KEY (`Club_ID_1`) REFERENCES `sports_competition`.`club` (`Club_ID`)
);
