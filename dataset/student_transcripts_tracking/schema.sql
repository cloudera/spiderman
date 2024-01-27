CREATE DATABASE IF NOT EXISTS `student_transcripts_tracking`;

drop table if exists `student_transcripts_tracking`.`Addresses`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Addresses` (
    `address_id` INT,
    `line_1` STRING,
    `line_2` STRING,
    `line_3` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    `other_address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Addresses.csv' INTO TABLE `student_transcripts_tracking`.`Addresses`;


drop table if exists `student_transcripts_tracking`.`Courses`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Courses` (
    `course_id` INT,
    `course_name` STRING,
    `course_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Courses.csv' INTO TABLE `student_transcripts_tracking`.`Courses`;


drop table if exists `student_transcripts_tracking`.`Departments`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Departments` (
    `department_id` INT,
    `department_name` STRING,
    `department_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`department_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Departments.csv' INTO TABLE `student_transcripts_tracking`.`Departments`;


drop table if exists `student_transcripts_tracking`.`Degree_Programs`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Degree_Programs` (
    `degree_program_id` INT,
    `department_id` INT NOT NULL,
    `degree_summary_name` STRING,
    `degree_summary_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`degree_program_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`department_id`) REFERENCES `student_transcripts_tracking`.`Departments` (`department_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Degree_Programs.csv' INTO TABLE `student_transcripts_tracking`.`Degree_Programs`;


drop table if exists `student_transcripts_tracking`.`Sections`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Sections` (
    `section_id` INT,
    `course_id` INT NOT NULL,
    `section_name` STRING,
    `section_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`section_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `student_transcripts_tracking`.`Courses` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Sections.csv' INTO TABLE `student_transcripts_tracking`.`Sections`;


drop table if exists `student_transcripts_tracking`.`Semesters`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Semesters` (
    `semester_id` INT,
    `semester_name` STRING,
    `semester_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`semester_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Semesters.csv' INTO TABLE `student_transcripts_tracking`.`Semesters`;


drop table if exists `student_transcripts_tracking`.`Students`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Students` (
    `student_id` INT,
    `current_address_id` INT NOT NULL,
    `permanent_address_id` INT NOT NULL,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `cell_mobile_number` STRING,
    `email_address` STRING,
    `ssn` STRING,
    `date_first_registered` TIMESTAMP,
    `date_left` TIMESTAMP,
    `other_student_details` STRING,
    PRIMARY KEY (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`permanent_address_id`) REFERENCES `student_transcripts_tracking`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`current_address_id`) REFERENCES `student_transcripts_tracking`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Students.csv' INTO TABLE `student_transcripts_tracking`.`Students`;


drop table if exists `student_transcripts_tracking`.`Student_Enrolment`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Student_Enrolment` (
    `student_enrolment_id` INT,
    `degree_program_id` INT NOT NULL,
    `semester_id` INT NOT NULL,
    `student_id` INT NOT NULL,
    `other_details` STRING,
    PRIMARY KEY (`student_enrolment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `student_transcripts_tracking`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`semester_id`) REFERENCES `student_transcripts_tracking`.`Semesters` (`semester_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`degree_program_id`) REFERENCES `student_transcripts_tracking`.`Degree_Programs` (`degree_program_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Student_Enrolment.csv' INTO TABLE `student_transcripts_tracking`.`Student_Enrolment`;


drop table if exists `student_transcripts_tracking`.`Student_Enrolment_Courses`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Student_Enrolment_Courses` (
    `student_course_id` INT,
    `course_id` INT NOT NULL,
    `student_enrolment_id` INT NOT NULL,
    PRIMARY KEY (`student_course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_enrolment_id`) REFERENCES `student_transcripts_tracking`.`Student_Enrolment` (`student_enrolment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `student_transcripts_tracking`.`Courses` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Student_Enrolment_Courses.csv' INTO TABLE `student_transcripts_tracking`.`Student_Enrolment_Courses`;


drop table if exists `student_transcripts_tracking`.`Transcripts`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Transcripts` (
    `transcript_id` INT,
    `transcript_date` TIMESTAMP,
    `other_details` STRING,
    PRIMARY KEY (`transcript_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Transcripts.csv' INTO TABLE `student_transcripts_tracking`.`Transcripts`;


drop table if exists `student_transcripts_tracking`.`Transcript_Contents`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Transcript_Contents` (
    `student_course_id` INT NOT NULL,
    `transcript_id` INT NOT NULL,
    FOREIGN KEY (`transcript_id`) REFERENCES `student_transcripts_tracking`.`Transcripts` (`transcript_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_course_id`) REFERENCES `student_transcripts_tracking`.`Student_Enrolment_Courses` (`student_course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Transcript_Contents.csv' INTO TABLE `student_transcripts_tracking`.`Transcript_Contents`;

