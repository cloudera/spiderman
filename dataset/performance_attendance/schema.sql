CREATE DATABASE IF NOT EXISTS `performance_attendance`;

drop table if exists `performance_attendance`.`member`;
CREATE TABLE IF NOT EXISTS `performance_attendance`.`member` (
    `Member_ID` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Role` STRING,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/performance_attendance/data/member.csv' INTO TABLE `performance_attendance`.`member`;


drop table if exists `performance_attendance`.`performance`;
CREATE TABLE IF NOT EXISTS `performance_attendance`.`performance` (
    `Performance_ID` INT,
    `Date` STRING,
    `Host` STRING,
    `Location` STRING,
    `Attendance` INT,
    PRIMARY KEY (`Performance_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/performance_attendance/data/performance.csv' INTO TABLE `performance_attendance`.`performance`;


drop table if exists `performance_attendance`.`member_attendance`;
CREATE TABLE IF NOT EXISTS `performance_attendance`.`member_attendance` (
    `Member_ID` INT,
    `Performance_ID` INT,
    `Num_of_Pieces` INT,
    PRIMARY KEY (`Member_ID`, `Performance_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Performance_ID`) REFERENCES `performance_attendance`.`performance` (`Performance_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `performance_attendance`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/performance_attendance/data/member_attendance.csv' INTO TABLE `performance_attendance`.`member_attendance`;

