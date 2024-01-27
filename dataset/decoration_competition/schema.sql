drop table if exists `decoration_competition`.`college`;
CREATE TABLE IF NOT EXISTS `decoration_competition`.`college` (
    `College_ID` INT,
    `Name` STRING,
    `Leader_Name` STRING,
    `College_Location` STRING,
    PRIMARY KEY (`College_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/decoration_competition/data/college.csv' INTO TABLE `decoration_competition`.`college`;


drop table if exists `decoration_competition`.`member`;
CREATE TABLE IF NOT EXISTS `decoration_competition`.`member` (
    `Member_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `College_ID` INT,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`College_ID`) REFERENCES `decoration_competition`.`college` (`College_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/decoration_competition/data/member.csv' INTO TABLE `decoration_competition`.`member`;


drop table if exists `decoration_competition`.`round`;
CREATE TABLE IF NOT EXISTS `decoration_competition`.`round` (
    `Round_ID` INT,
    `Member_ID` INT,
    `Decoration_Theme` STRING,
    `Rank_in_Round` INT,
    PRIMARY KEY (`Round_ID`, `Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `decoration_competition`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/decoration_competition/data/round.csv' INTO TABLE `decoration_competition`.`round`;
