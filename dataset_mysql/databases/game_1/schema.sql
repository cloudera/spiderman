-- Dialect: mysql | Database: game_1 | Table Count: 4

CREATE TABLE `game_1`.`Student` (
    `StuID` INTEGER,
    `LName` VARCHAR(12),
    `Fname` VARCHAR(12),
    `Age` INTEGER,
    `Sex` VARCHAR(1),
    `Major` INTEGER,
    `Advisor` INTEGER,
    `city_code` VARCHAR(3),
    PRIMARY KEY (`StuID`)
);

CREATE TABLE `game_1`.`Video_Games` (
    `GameID` INTEGER,
    `GName` VARCHAR(40),
    `GType` VARCHAR(40),
    PRIMARY KEY (`GameID`)
);

CREATE TABLE `game_1`.`Plays_Games` (
    `StuID` INTEGER,
    `GameID` INTEGER,
    `Hours_Played` INTEGER,
    FOREIGN KEY (`StuID`) REFERENCES `game_1`.`Student` (`StuID`),
    FOREIGN KEY (`GameID`) REFERENCES `game_1`.`Video_Games` (`GameID`)
);

CREATE TABLE `game_1`.`SportsInfo` (
    `StuID` INTEGER,
    `SportName` VARCHAR(32),
    `HoursPerWeek` INTEGER,
    `GamesPlayed` INTEGER,
    `OnScholarship` VARCHAR(1),
    FOREIGN KEY (`StuID`) REFERENCES `game_1`.`Student` (`StuID`)
);
