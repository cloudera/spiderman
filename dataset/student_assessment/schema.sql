drop table if exists `student_assessment`.`Addresses`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Addresses` (
    `address_id` INT NOT NULL,
    `line_1` STRING,
    `line_2` STRING,
    `city` STRING,
    `zip_postcode` CHAR(20),
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Addresses.csv' INTO TABLE `student_assessment`.`Addresses`;


drop table if exists `student_assessment`.`People`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`People` (
    `person_id` INT NOT NULL,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `cell_mobile_number` STRING,
    `email_address` STRING,
    `login_name` STRING,
    `password` STRING,
    PRIMARY KEY (`person_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/People.csv' INTO TABLE `student_assessment`.`People`;


drop table if exists `student_assessment`.`Students`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Students` (
    `student_id` INT NOT NULL,
    `student_details` STRING,
    PRIMARY KEY (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `student_assessment`.`People` (`person_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Students.csv' INTO TABLE `student_assessment`.`Students`;


drop table if exists `student_assessment`.`Courses`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Courses` (
    `course_id` INT NOT NULL,
    `course_name` STRING,
    `course_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Courses.csv' INTO TABLE `student_assessment`.`Courses`;


drop table if exists `student_assessment`.`People_Addresses`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`People_Addresses` (
    `person_address_id` INT NOT NULL,
    `person_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP,
    `date_to` TIMESTAMP,
    PRIMARY KEY (`person_address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `student_assessment`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`person_id`) REFERENCES `student_assessment`.`People` (`person_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/People_Addresses.csv' INTO TABLE `student_assessment`.`People_Addresses`;


drop table if exists `student_assessment`.`Student_Course_Registrations`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Student_Course_Registrations` (
    `student_id` INT NOT NULL,
    `course_id` INT NOT NULL,
    `registration_date` TIMESTAMP NOT NULL,
    PRIMARY KEY (`student_id`, `course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `student_assessment`.`Courses` (`course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `student_assessment`.`Students` (`student_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Student_Course_Registrations.csv' INTO TABLE `student_assessment`.`Student_Course_Registrations`;


drop table if exists `student_assessment`.`Student_Course_Attendance`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Student_Course_Attendance` (
    `student_id` INT NOT NULL,
    `course_id` INT NOT NULL,
    `date_of_attendance` TIMESTAMP NOT NULL,
    PRIMARY KEY (`student_id`, `course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`, `course_id`) REFERENCES `student_assessment`.`Student_Course_Registrations` (`student_id`, `course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Student_Course_Attendance.csv' INTO TABLE `student_assessment`.`Student_Course_Attendance`;


drop table if exists `student_assessment`.`Candidates`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Candidates` (
    `candidate_id` INT NOT NULL,
    `candidate_details` STRING,
    PRIMARY KEY (`candidate_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`candidate_id`) REFERENCES `student_assessment`.`People` (`person_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Candidates.csv' INTO TABLE `student_assessment`.`Candidates`;


drop table if exists `student_assessment`.`Candidate_Assessments`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Candidate_Assessments` (
    `candidate_id` INT NOT NULL,
    `qualification` CHAR(15) NOT NULL,
    `assessment_date` TIMESTAMP NOT NULL,
    `asessment_outcome_code` CHAR(15) NOT NULL,
    PRIMARY KEY (`candidate_id`, `qualification`) DISABLE NOVALIDATE,
    FOREIGN KEY (`candidate_id`) REFERENCES `student_assessment`.`Candidates` (`candidate_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Candidate_Assessments.csv' INTO TABLE `student_assessment`.`Candidate_Assessments`;

