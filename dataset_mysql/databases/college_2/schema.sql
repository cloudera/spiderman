-- Dialect: mysql | Database: college_2 | Table Count: 11

CREATE TABLE `college_2`.`classroom` (
    `building` VARCHAR(15),
    `room_number` VARCHAR(7),
    `capacity` NUMERIC(4,0),
    PRIMARY KEY (`building`, `room_number`)
);

CREATE TABLE `college_2`.`department` (
    `dept_name` VARCHAR(20),
    `building` VARCHAR(15),
    `budget` NUMERIC(12,2),
    PRIMARY KEY (`dept_name`)
);

CREATE TABLE `college_2`.`course` (
    `course_id` VARCHAR(8),
    `title` VARCHAR(50),
    `dept_name` VARCHAR(20),
    `credits` NUMERIC(2,0),
    PRIMARY KEY (`course_id`),
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`)
);

CREATE TABLE `college_2`.`instructor` (
    `ID` VARCHAR(5),
    `name` VARCHAR(20) NOT NULL,
    `dept_name` VARCHAR(20),
    `salary` NUMERIC(8,2),
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`)
);

CREATE TABLE `college_2`.`section` (
    `course_id` VARCHAR(8),
    `sec_id` VARCHAR(8),
    `semester` VARCHAR(6),
    `year` NUMERIC(4,0),
    `building` VARCHAR(15),
    `room_number` VARCHAR(7),
    `time_slot_id` VARCHAR(4),
    PRIMARY KEY (`course_id`, `sec_id`, `semester`, `year`),
    FOREIGN KEY (`building`, `room_number`) REFERENCES `college_2`.`classroom` (`building`, `room_number`),
    FOREIGN KEY (`course_id`) REFERENCES `college_2`.`course` (`course_id`)
);

CREATE TABLE `college_2`.`teaches` (
    `ID` VARCHAR(5),
    `course_id` VARCHAR(8),
    `sec_id` VARCHAR(8),
    `semester` VARCHAR(6),
    `year` NUMERIC(4,0),
    PRIMARY KEY (`ID`, `course_id`, `sec_id`, `semester`, `year`),
    FOREIGN KEY (`ID`) REFERENCES `college_2`.`instructor` (`ID`),
    FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `college_2`.`section` (`course_id`, `sec_id`, `semester`, `year`)
);

CREATE TABLE `college_2`.`student` (
    `ID` VARCHAR(5),
    `name` VARCHAR(20) NOT NULL,
    `dept_name` VARCHAR(20),
    `tot_cred` NUMERIC(3,0),
    PRIMARY KEY (`ID`),
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`)
);

CREATE TABLE `college_2`.`takes` (
    `ID` VARCHAR(5),
    `course_id` VARCHAR(8),
    `sec_id` VARCHAR(8),
    `semester` VARCHAR(6),
    `year` NUMERIC(4,0),
    `grade` VARCHAR(2),
    PRIMARY KEY (`ID`, `course_id`, `sec_id`, `semester`, `year`),
    FOREIGN KEY (`ID`) REFERENCES `college_2`.`student` (`ID`),
    FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `college_2`.`section` (`course_id`, `sec_id`, `semester`, `year`)
);

CREATE TABLE `college_2`.`advisor` (
    `s_ID` VARCHAR(5),
    `i_ID` VARCHAR(5),
    PRIMARY KEY (`s_ID`),
    FOREIGN KEY (`s_ID`) REFERENCES `college_2`.`student` (`ID`),
    FOREIGN KEY (`i_ID`) REFERENCES `college_2`.`instructor` (`ID`)
);

CREATE TABLE `college_2`.`time_slot` (
    `time_slot_id` VARCHAR(4),
    `day` VARCHAR(1),
    `start_hr` NUMERIC(2),
    `start_min` NUMERIC(2),
    `end_hr` NUMERIC(2),
    `end_min` NUMERIC(2),
    PRIMARY KEY (`time_slot_id`, `day`, `start_hr`, `start_min`)
);

CREATE TABLE `college_2`.`prereq` (
    `course_id` VARCHAR(8),
    `prereq_id` VARCHAR(8),
    PRIMARY KEY (`course_id`, `prereq_id`),
    FOREIGN KEY (`prereq_id`) REFERENCES `college_2`.`course` (`course_id`),
    FOREIGN KEY (`course_id`) REFERENCES `college_2`.`course` (`course_id`)
);
