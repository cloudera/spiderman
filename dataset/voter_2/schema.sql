CREATE DATABASE IF NOT EXISTS `voter_2`;

drop table if exists `voter_2`.`Student`;
CREATE TABLE IF NOT EXISTS `voter_2`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_2/data/Student.csv' INTO TABLE `voter_2`.`Student`;


drop table if exists `voter_2`.`Voting_record`;
CREATE TABLE IF NOT EXISTS `voter_2`.`Voting_record` (
    `StuID` INT,
    `Registration_Date` STRING,
    `Election_Cycle` STRING,
    `President_Vote` INT,
    `Vice_President_Vote` INT,
    `Secretary_Vote` INT,
    `Treasurer_Vote` INT,
    `Class_President_Vote` INT,
    `Class_Senator_Vote` INT,
    FOREIGN KEY (`Class_Senator_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Class_President_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Treasurer_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Secretary_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Vice_President_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`President_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_2/data/Voting_record.csv' INTO TABLE `voter_2`.`Voting_record`;

