drop table if exists `student_1`.`list`;
CREATE TABLE IF NOT EXISTS `student_1`.`list` (
    `LastName` STRING,
    `FirstName` STRING,
    `Grade` INT,
    `Classroom` INT,
    PRIMARY KEY (`LastName`, `FirstName`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_1/data/list.csv' INTO TABLE `student_1`.`list`;


drop table if exists `student_1`.`teachers`;
CREATE TABLE IF NOT EXISTS `student_1`.`teachers` (
    `LastName` STRING,
    `FirstName` STRING,
    `Classroom` INT,
    PRIMARY KEY (`LastName`, `FirstName`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_1/data/teachers.csv' INTO TABLE `student_1`.`teachers`;

