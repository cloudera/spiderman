CREATE DATABASE IF NOT EXISTS `behavior_monitoring`;

drop table if exists `behavior_monitoring`.`Ref_Address_Types`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Ref_Address_Types` (
    `address_type_code` STRING,
    `address_type_description` STRING,
    PRIMARY KEY (`address_type_code`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Ref_Detention_Type`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Ref_Detention_Type` (
    `detention_type_code` STRING,
    `detention_type_description` STRING,
    PRIMARY KEY (`detention_type_code`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Ref_Incident_Type`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Ref_Incident_Type` (
    `incident_type_code` STRING,
    `incident_type_description` STRING,
    PRIMARY KEY (`incident_type_code`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Addresses`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Addresses` (
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
);

drop table if exists `behavior_monitoring`.`Students`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Students` (
    `student_id` INT,
    `address_id` INT NOT NULL,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `cell_mobile_number` STRING,
    `email_address` STRING,
    `date_first_rental` TIMESTAMP,
    `date_left_university` TIMESTAMP,
    `other_student_details` STRING,
    PRIMARY KEY (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `behavior_monitoring`.`Addresses` (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Teachers`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Teachers` (
    `teacher_id` INT,
    `address_id` INT NOT NULL,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `gender` STRING,
    `cell_mobile_number` STRING,
    `email_address` STRING,
    `other_details` STRING,
    PRIMARY KEY (`teacher_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `behavior_monitoring`.`Addresses` (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Assessment_Notes`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Assessment_Notes` (
    `notes_id` INT NOT NULL,
    `student_id` INT,
    `teacher_id` INT NOT NULL,
    `date_of_notes` TIMESTAMP,
    `text_of_notes` STRING,
    `other_details` STRING,
    FOREIGN KEY (`teacher_id`) REFERENCES `behavior_monitoring`.`Teachers` (`teacher_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `behavior_monitoring`.`Students` (`student_id`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Behavior_Incident`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Behavior_Incident` (
    `incident_id` INT,
    `incident_type_code` STRING NOT NULL,
    `student_id` INT NOT NULL,
    `date_incident_start` TIMESTAMP,
    `date_incident_end` TIMESTAMP,
    `incident_summary` STRING,
    `recommendations` STRING,
    `other_details` STRING,
    PRIMARY KEY (`incident_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `behavior_monitoring`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`incident_type_code`) REFERENCES `behavior_monitoring`.`Ref_Incident_Type` (`incident_type_code`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Detention`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Detention` (
    `detention_id` INT,
    `detention_type_code` STRING NOT NULL,
    `teacher_id` INT,
    `datetime_detention_start` TIMESTAMP,
    `datetime_detention_end` TIMESTAMP,
    `detention_summary` STRING,
    `other_details` STRING,
    PRIMARY KEY (`detention_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`teacher_id`) REFERENCES `behavior_monitoring`.`Teachers` (`teacher_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`detention_type_code`) REFERENCES `behavior_monitoring`.`Ref_Detention_Type` (`detention_type_code`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Student_Addresses`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Student_Addresses` (
    `student_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_address_from` TIMESTAMP NOT NULL,
    `date_address_to` TIMESTAMP,
    `monthly_rental` DECIMAL(19,4),
    `other_details` STRING,
    FOREIGN KEY (`student_id`) REFERENCES `behavior_monitoring`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `behavior_monitoring`.`Addresses` (`address_id`) DISABLE NOVALIDATE
);

drop table if exists `behavior_monitoring`.`Students_in_Detention`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Students_in_Detention` (
    `student_id` INT NOT NULL,
    `detention_id` INT NOT NULL,
    `incident_id` INT NOT NULL,
    FOREIGN KEY (`student_id`) REFERENCES `behavior_monitoring`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`detention_id`) REFERENCES `behavior_monitoring`.`Detention` (`detention_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`incident_id`) REFERENCES `behavior_monitoring`.`Behavior_Incident` (`incident_id`) DISABLE NOVALIDATE
);
