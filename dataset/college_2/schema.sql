CREATE DATABASE IF NOT EXISTS `college_2`;

drop table if exists `college_2`.`classroom`;
CREATE TABLE IF NOT EXISTS `college_2`.`classroom` (
    `building` STRING,
    `room_number` STRING,
    `capacity` NUMERIC(4,0),
    PRIMARY KEY (`building`, `room_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/classroom.csv' INTO TABLE `college_2`.`classroom`;


drop table if exists `college_2`.`department`;
CREATE TABLE IF NOT EXISTS `college_2`.`department` (
    `dept_name` STRING,
    `building` STRING,
    `budget` NUMERIC(12,2),
    PRIMARY KEY (`dept_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/department.csv' INTO TABLE `college_2`.`department`;


drop table if exists `college_2`.`course`;
CREATE TABLE IF NOT EXISTS `college_2`.`course` (
    `course_id` STRING,
    `title` STRING,
    `dept_name` STRING,
    `credits` NUMERIC(2,0),
    PRIMARY KEY (`course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/course.csv' INTO TABLE `college_2`.`course`;


drop table if exists `college_2`.`instructor`;
CREATE TABLE IF NOT EXISTS `college_2`.`instructor` (
    `ID` STRING,
    `name` STRING NOT NULL,
    `dept_name` STRING,
    `salary` NUMERIC(8,2),
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/instructor.csv' INTO TABLE `college_2`.`instructor`;


drop table if exists `college_2`.`section`;
CREATE TABLE IF NOT EXISTS `college_2`.`section` (
    `course_id` STRING,
    `sec_id` STRING,
    `semester` STRING,
    `year` NUMERIC(4,0),
    `building` STRING,
    `room_number` STRING,
    `time_slot_id` STRING,
    PRIMARY KEY (`course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building`, `room_number`) REFERENCES `college_2`.`classroom` (`building`, `room_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `college_2`.`course` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/section.csv' INTO TABLE `college_2`.`section`;


drop table if exists `college_2`.`teaches`;
CREATE TABLE IF NOT EXISTS `college_2`.`teaches` (
    `ID` STRING,
    `course_id` STRING,
    `sec_id` STRING,
    `semester` STRING,
    `year` NUMERIC(4,0),
    PRIMARY KEY (`ID`, `course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`ID`) REFERENCES `college_2`.`instructor` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `college_2`.`section` (`course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/teaches.csv' INTO TABLE `college_2`.`teaches`;


drop table if exists `college_2`.`student`;
CREATE TABLE IF NOT EXISTS `college_2`.`student` (
    `ID` STRING,
    `name` STRING NOT NULL,
    `dept_name` STRING,
    `tot_cred` NUMERIC(3,0),
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/student.csv' INTO TABLE `college_2`.`student`;


drop table if exists `college_2`.`takes`;
CREATE TABLE IF NOT EXISTS `college_2`.`takes` (
    `ID` STRING,
    `course_id` STRING,
    `sec_id` STRING,
    `semester` STRING,
    `year` NUMERIC(4,0),
    `grade` STRING,
    PRIMARY KEY (`ID`, `course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`ID`) REFERENCES `college_2`.`student` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `college_2`.`section` (`course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/takes.csv' INTO TABLE `college_2`.`takes`;


drop table if exists `college_2`.`advisor`;
CREATE TABLE IF NOT EXISTS `college_2`.`advisor` (
    `s_ID` STRING,
    `i_ID` STRING,
    PRIMARY KEY (`s_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`s_ID`) REFERENCES `college_2`.`student` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`i_ID`) REFERENCES `college_2`.`instructor` (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/advisor.csv' INTO TABLE `college_2`.`advisor`;


drop table if exists `college_2`.`time_slot`;
CREATE TABLE IF NOT EXISTS `college_2`.`time_slot` (
    `time_slot_id` STRING,
    `day` STRING,
    `start_hr` NUMERIC(2),
    `start_min` NUMERIC(2),
    `end_hr` NUMERIC(2),
    `end_min` NUMERIC(2),
    PRIMARY KEY (`time_slot_id`, `day`, `start_hr`, `start_min`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/time_slot.csv' INTO TABLE `college_2`.`time_slot`;


drop table if exists `college_2`.`prereq`;
CREATE TABLE IF NOT EXISTS `college_2`.`prereq` (
    `course_id` STRING,
    `prereq_id` STRING,
    PRIMARY KEY (`course_id`, `prereq_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`prereq_id`) REFERENCES `college_2`.`course` (`course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `college_2`.`course` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/prereq.csv' INTO TABLE `college_2`.`prereq`;

