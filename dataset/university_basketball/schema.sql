drop table if exists `university_basketball`.`university`;
CREATE TABLE IF NOT EXISTS `university_basketball`.`university` (
    `School_ID` INT,
    `School` STRING,
    `Location` STRING,
    `Founded` REAL,
    `Affiliation` STRING,
    `Enrollment` REAL,
    `Nickname` STRING,
    `Primary_conference` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/university_basketball/data/university.csv' INTO TABLE `university_basketball`.`university`;


drop table if exists `university_basketball`.`basketball_match`;
CREATE TABLE IF NOT EXISTS `university_basketball`.`basketball_match` (
    `Team_ID` INT,
    `School_ID` INT,
    `Team_Name` STRING,
    `ACC_Regular_Season` STRING,
    `ACC_Percent` STRING,
    `ACC_Home` STRING,
    `ACC_Road` STRING,
    `All_Games` STRING,
    `All_Games_Percent` INT,
    `All_Home` STRING,
    `All_Road` STRING,
    `All_Neutral` STRING,
    PRIMARY KEY (`Team_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `university_basketball`.`university` (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/university_basketball/data/basketball_match.csv' INTO TABLE `university_basketball`.`basketball_match`;

