drop table if exists `course_teach`.`course`;
CREATE TABLE IF NOT EXISTS `course_teach`.`course` (
    `Course_ID` INT,
    `Staring_Date` STRING,
    `Course` STRING,
    PRIMARY KEY (`Course_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/course_teach/data/course.csv' INTO TABLE `course_teach`.`course`;


drop table if exists `course_teach`.`teacher`;
CREATE TABLE IF NOT EXISTS `course_teach`.`teacher` (
    `Teacher_ID` INT,
    `Name` STRING,
    `Age` STRING,
    `Hometown` STRING,
    PRIMARY KEY (`Teacher_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/course_teach/data/teacher.csv' INTO TABLE `course_teach`.`teacher`;


drop table if exists `course_teach`.`course_arrange`;
CREATE TABLE IF NOT EXISTS `course_teach`.`course_arrange` (
    `Course_ID` INT,
    `Teacher_ID` INT,
    `Grade` INT,
    PRIMARY KEY (`Course_ID`, `Teacher_ID`, `Grade`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Teacher_ID`) REFERENCES `course_teach`.`teacher` (`Teacher_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Course_ID`) REFERENCES `course_teach`.`course` (`Course_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/course_teach/data/course_arrange.csv' INTO TABLE `course_teach`.`course_arrange`;
