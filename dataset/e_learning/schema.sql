CREATE DATABASE IF NOT EXISTS `e_learning`;

drop table if exists `e_learning`.`Course_Authors_and_Tutors`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Course_Authors_and_Tutors` (
    `author_id` INT,
    `author_tutor_ATB` STRING,
    `login_name` STRING,
    `password` STRING,
    `personal_name` STRING,
    `middle_name` STRING,
    `family_name` STRING,
    `gender_mf` STRING,
    `address_line_1` STRING,
    PRIMARY KEY (`author_id`) DISABLE NOVALIDATE
);

drop table if exists `e_learning`.`Students`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Students` (
    `student_id` INT,
    `date_of_registration` TIMESTAMP,
    `date_of_latest_logon` TIMESTAMP,
    `login_name` STRING,
    `password` STRING,
    `personal_name` STRING,
    `middle_name` STRING,
    `family_name` STRING,
    PRIMARY KEY (`student_id`) DISABLE NOVALIDATE
);

drop table if exists `e_learning`.`Subjects`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Subjects` (
    `subject_id` INT,
    `subject_name` STRING,
    PRIMARY KEY (`subject_id`) DISABLE NOVALIDATE
);

drop table if exists `e_learning`.`Courses`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Courses` (
    `course_id` INT,
    `author_id` INT NOT NULL,
    `subject_id` INT NOT NULL,
    `course_name` STRING,
    `course_description` STRING,
    PRIMARY KEY (`course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`subject_id`) REFERENCES `e_learning`.`Subjects` (`subject_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`author_id`) REFERENCES `e_learning`.`Course_Authors_and_Tutors` (`author_id`) DISABLE NOVALIDATE
);

drop table if exists `e_learning`.`Student_Course_Enrolment`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Student_Course_Enrolment` (
    `registration_id` INT,
    `student_id` INT NOT NULL,
    `course_id` INT NOT NULL,
    `date_of_enrolment` TIMESTAMP NOT NULL,
    `date_of_completion` TIMESTAMP NOT NULL,
    PRIMARY KEY (`registration_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `e_learning`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `e_learning`.`Courses` (`course_id`) DISABLE NOVALIDATE
);

drop table if exists `e_learning`.`Student_Tests_Taken`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Student_Tests_Taken` (
    `registration_id` INT NOT NULL,
    `date_test_taken` TIMESTAMP NOT NULL,
    `test_result` STRING,
    FOREIGN KEY (`registration_id`) REFERENCES `e_learning`.`Student_Course_Enrolment` (`registration_id`) DISABLE NOVALIDATE
);
