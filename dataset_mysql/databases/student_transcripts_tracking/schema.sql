-- Dialect: mysql | Database: student_transcripts_tracking | Table Count: 11

CREATE TABLE `student_transcripts_tracking`.`Addresses` (
    `address_id` INTEGER,
    `line_1` VARCHAR(255),
    `line_2` VARCHAR(255),
    `line_3` VARCHAR(255),
    `city` VARCHAR(255),
    `zip_postcode` VARCHAR(20),
    `state_province_county` VARCHAR(255),
    `country` VARCHAR(255),
    `other_address_details` VARCHAR(255),
    PRIMARY KEY (`address_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Courses` (
    `course_id` INTEGER,
    `course_name` VARCHAR(255),
    `course_description` VARCHAR(255),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`course_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Departments` (
    `department_id` INTEGER,
    `department_name` VARCHAR(255),
    `department_description` VARCHAR(255),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`department_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Degree_Programs` (
    `degree_program_id` INTEGER,
    `department_id` INTEGER NOT NULL,
    `degree_summary_name` VARCHAR(255),
    `degree_summary_description` VARCHAR(255),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`degree_program_id`),
    FOREIGN KEY (`department_id`) REFERENCES `student_transcripts_tracking`.`Departments` (`department_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Sections` (
    `section_id` INTEGER,
    `course_id` INTEGER NOT NULL,
    `section_name` VARCHAR(255),
    `section_description` VARCHAR(255),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`section_id`),
    FOREIGN KEY (`course_id`) REFERENCES `student_transcripts_tracking`.`Courses` (`course_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Semesters` (
    `semester_id` INTEGER,
    `semester_name` VARCHAR(255),
    `semester_description` VARCHAR(255),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`semester_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Students` (
    `student_id` INTEGER,
    `current_address_id` INTEGER NOT NULL,
    `permanent_address_id` INTEGER NOT NULL,
    `first_name` VARCHAR(80),
    `middle_name` VARCHAR(40),
    `last_name` VARCHAR(40),
    `cell_mobile_number` VARCHAR(40),
    `email_address` VARCHAR(40),
    `ssn` VARCHAR(40),
    `date_first_registered` DATETIME,
    `date_left` DATETIME,
    `other_student_details` VARCHAR(255),
    PRIMARY KEY (`student_id`),
    FOREIGN KEY (`permanent_address_id`) REFERENCES `student_transcripts_tracking`.`Addresses` (`address_id`),
    FOREIGN KEY (`current_address_id`) REFERENCES `student_transcripts_tracking`.`Addresses` (`address_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Student_Enrolment` (
    `student_enrolment_id` INTEGER,
    `degree_program_id` INTEGER NOT NULL,
    `semester_id` INTEGER NOT NULL,
    `student_id` INTEGER NOT NULL,
    `other_details` VARCHAR(255),
    PRIMARY KEY (`student_enrolment_id`),
    FOREIGN KEY (`student_id`) REFERENCES `student_transcripts_tracking`.`Students` (`student_id`),
    FOREIGN KEY (`semester_id`) REFERENCES `student_transcripts_tracking`.`Semesters` (`semester_id`),
    FOREIGN KEY (`degree_program_id`) REFERENCES `student_transcripts_tracking`.`Degree_Programs` (`degree_program_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Student_Enrolment_Courses` (
    `student_course_id` INTEGER,
    `course_id` INTEGER NOT NULL,
    `student_enrolment_id` INTEGER NOT NULL,
    PRIMARY KEY (`student_course_id`),
    FOREIGN KEY (`student_enrolment_id`) REFERENCES `student_transcripts_tracking`.`Student_Enrolment` (`student_enrolment_id`),
    FOREIGN KEY (`course_id`) REFERENCES `student_transcripts_tracking`.`Courses` (`course_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Transcripts` (
    `transcript_id` INTEGER,
    `transcript_date` DATETIME,
    `other_details` VARCHAR(255),
    PRIMARY KEY (`transcript_id`)
);

CREATE TABLE `student_transcripts_tracking`.`Transcript_Contents` (
    `student_course_id` INTEGER NOT NULL,
    `transcript_id` INTEGER NOT NULL,
    FOREIGN KEY (`transcript_id`) REFERENCES `student_transcripts_tracking`.`Transcripts` (`transcript_id`),
    FOREIGN KEY (`student_course_id`) REFERENCES `student_transcripts_tracking`.`Student_Enrolment_Courses` (`student_course_id`)
);
