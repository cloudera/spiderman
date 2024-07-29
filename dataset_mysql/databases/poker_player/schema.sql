-- Dialect: MySQL | Database: poker_player | Table Count: 2

CREATE DATABASE IF NOT EXISTS `poker_player`;

DROP TABLE IF EXISTS `poker_player`.`people`;
CREATE TABLE `poker_player`.`people` (
    `People_ID` INT,
    `Nationality` TEXT,
    `Name` TEXT,
    `Birth_Date` TEXT,
    `Height` REAL,
    PRIMARY KEY (`People_ID`)
);

DROP TABLE IF EXISTS `poker_player`.`poker_player`;
CREATE TABLE `poker_player`.`poker_player` (
    `Poker_Player_ID` INT,
    `People_ID` INT,
    `Final_Table_Made` REAL,
    `Best_Finish` REAL,
    `Money_Rank` REAL,
    `Earnings` REAL,
    PRIMARY KEY (`Poker_Player_ID`),
    FOREIGN KEY (`People_ID`) REFERENCES `poker_player`.`people` (`People_ID`)
);
