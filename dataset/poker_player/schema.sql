CREATE DATABASE IF NOT EXISTS `poker_player`;

drop table if exists `poker_player`.`people`;
CREATE TABLE IF NOT EXISTS `poker_player`.`people` (
    `People_ID` INT,
    `Nationality` STRING,
    `Name` STRING,
    `Birth_Date` STRING,
    `Height` DOUBLE,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
);

drop table if exists `poker_player`.`poker_player`;
CREATE TABLE IF NOT EXISTS `poker_player`.`poker_player` (
    `Poker_Player_ID` INT,
    `People_ID` INT,
    `Final_Table_Made` DOUBLE,
    `Best_Finish` DOUBLE,
    `Money_Rank` DOUBLE,
    `Earnings` DOUBLE,
    PRIMARY KEY (`Poker_Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `poker_player`.`people` (`People_ID`) DISABLE NOVALIDATE
);
