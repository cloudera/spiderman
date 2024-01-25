drop table if exists `poker_player`.`people`;
CREATE TABLE IF NOT EXISTS `poker_player`.`people` (
    `People_ID` INT,
    `Nationality` STRING,
    `Name` STRING,
    `Birth_Date` STRING,
    `Height` REAL,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/poker_player/data/people.csv' INTO TABLE `poker_player`.`people`;


drop table if exists `poker_player`.`poker_player`;
CREATE TABLE IF NOT EXISTS `poker_player`.`poker_player` (
    `Poker_Player_ID` INT,
    `People_ID` INT,
    `Final_Table_Made` REAL,
    `Best_Finish` REAL,
    `Money_Rank` REAL,
    `Earnings` REAL,
    PRIMARY KEY (`Poker_Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `poker_player`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/poker_player/data/poker_player.csv' INTO TABLE `poker_player`.`poker_player`;

