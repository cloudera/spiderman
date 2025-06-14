-- Dialect: mysql | Database: e_learning | Table Count: 6

CREATE TABLE `e_learning`.`Course_Authors_and_Tutors` (
    `author_id` INTEGER,
    `author_tutor_ATB` VARCHAR(3),
    `login_name` VARCHAR(40),
    `password` VARCHAR(40),
    `personal_name` VARCHAR(80),
    `middle_name` VARCHAR(80),
    `family_name` VARCHAR(80),
    `gender_mf` VARCHAR(1),
    `address_line_1` VARCHAR(80),
    PRIMARY KEY (`author_id`)
);

CREATE TABLE `e_learning`.`Students` (
    `student_id` INTEGER,
    `date_of_registration` DATETIME,
    `date_of_latest_logon` DATETIME,
    `login_name` VARCHAR(40),
    `password` VARCHAR(10),
    `personal_name` VARCHAR(40),
    `middle_name` VARCHAR(40),
    `family_name` VARCHAR(40),
    PRIMARY KEY (`student_id`)
);

CREATE TABLE `e_learning`.`Subjects` (
    `subject_id` INTEGER,
    `subject_name` VARCHAR(120),
    PRIMARY KEY (`subject_id`)
);

CREATE TABLE `e_learning`.`Courses` (
    `course_id` INTEGER,
    `author_id` INTEGER NOT NULL,
    `subject_id` INTEGER NOT NULL,
    `course_name` VARCHAR(120),
    `course_description` VARCHAR(255),
    PRIMARY KEY (`course_id`),
    FOREIGN KEY (`subject_id`) REFERENCES `e_learning`.`Subjects` (`subject_id`),
    FOREIGN KEY (`author_id`) REFERENCES `e_learning`.`Course_Authors_and_Tutors` (`author_id`)
);

CREATE TABLE `e_learning`.`Student_Course_Enrolment` (
    `registration_id` INTEGER,
    `student_id` INTEGER NOT NULL,
    `course_id` INTEGER NOT NULL,
    `date_of_enrolment` DATETIME NOT NULL,
    `date_of_completion` DATETIME NOT NULL,
    PRIMARY KEY (`registration_id`),
    FOREIGN KEY (`student_id`) REFERENCES `e_learning`.`Students` (`student_id`),
    FOREIGN KEY (`course_id`) REFERENCES `e_learning`.`Courses` (`course_id`)
);

CREATE TABLE `e_learning`.`Student_Tests_Taken` (
    `registration_id` INTEGER NOT NULL,
    `date_test_taken` DATETIME NOT NULL,
    `test_result` VARCHAR(255),
    FOREIGN KEY (`registration_id`) REFERENCES `e_learning`.`Student_Course_Enrolment` (`registration_id`)
);
