-- Dialect: mysql | Database: tracking_software_problems | Table Count: 6

CREATE TABLE `tracking_software_problems`.`Problem_Category_Codes` (
    `problem_category_code` VARCHAR(20),
    `problem_category_description` VARCHAR(80),
    PRIMARY KEY (`problem_category_code`)
);

CREATE TABLE `tracking_software_problems`.`Problem_Status_Codes` (
    `problem_status_code` VARCHAR(20),
    `problem_status_description` VARCHAR(80),
    PRIMARY KEY (`problem_status_code`)
);

CREATE TABLE `tracking_software_problems`.`Staff` (
    `staff_id` INTEGER,
    `staff_first_name` VARCHAR(80),
    `staff_last_name` VARCHAR(80),
    `other_staff_details` VARCHAR(255),
    PRIMARY KEY (`staff_id`)
);

CREATE TABLE `tracking_software_problems`.`Product` (
    `product_id` INTEGER,
    `product_name` VARCHAR(80),
    `product_details` VARCHAR(255),
    PRIMARY KEY (`product_id`)
);

CREATE TABLE `tracking_software_problems`.`Problems` (
    `problem_id` INTEGER,
    `product_id` INTEGER NOT NULL,
    `closure_authorised_by_staff_id` INTEGER NOT NULL,
    `reported_by_staff_id` INTEGER NOT NULL,
    `date_problem_reported` DATETIME NOT NULL,
    `date_problem_closed` DATETIME,
    `problem_description` VARCHAR(255),
    `other_problem_details` VARCHAR(255),
    PRIMARY KEY (`problem_id`),
    FOREIGN KEY (`reported_by_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`),
    FOREIGN KEY (`product_id`) REFERENCES `tracking_software_problems`.`Product` (`product_id`),
    FOREIGN KEY (`closure_authorised_by_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`)
);

CREATE TABLE `tracking_software_problems`.`Problem_Log` (
    `problem_log_id` INTEGER,
    `assigned_to_staff_id` INTEGER NOT NULL,
    `problem_id` INTEGER NOT NULL,
    `problem_category_code` VARCHAR(20) NOT NULL,
    `problem_status_code` VARCHAR(20) NOT NULL,
    `log_entry_date` DATETIME,
    `log_entry_description` VARCHAR(255),
    `log_entry_fix` VARCHAR(255),
    `other_log_details` VARCHAR(255),
    PRIMARY KEY (`problem_log_id`),
    FOREIGN KEY (`problem_status_code`) REFERENCES `tracking_software_problems`.`Problem_Status_Codes` (`problem_status_code`),
    FOREIGN KEY (`problem_id`) REFERENCES `tracking_software_problems`.`Problems` (`problem_id`),
    FOREIGN KEY (`assigned_to_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`),
    FOREIGN KEY (`problem_category_code`) REFERENCES `tracking_software_problems`.`Problem_Category_Codes` (`problem_category_code`)
);
