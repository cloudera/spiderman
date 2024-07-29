-- Dialect: MySQL | Database: tracking_grants_for_research | Table Count: 12

CREATE DATABASE IF NOT EXISTS `tracking_grants_for_research`;

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Document_Types`;
CREATE TABLE `tracking_grants_for_research`.`Document_Types` (
    `document_type_code` VARCHAR(10),
    `document_description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`document_type_code`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Organisation_Types`;
CREATE TABLE `tracking_grants_for_research`.`Organisation_Types` (
    `organisation_type` VARCHAR(10),
    `organisation_type_description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`organisation_type`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Organisations`;
CREATE TABLE `tracking_grants_for_research`.`Organisations` (
    `organisation_id` INTEGER,
    `organisation_type` VARCHAR(10) NOT NULL,
    `organisation_details` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`organisation_id`),
    FOREIGN KEY (`organisation_type`) REFERENCES `tracking_grants_for_research`.`Organisation_Types` (`organisation_type`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Grants`;
CREATE TABLE `tracking_grants_for_research`.`Grants` (
    `grant_id` INTEGER,
    `organisation_id` INTEGER NOT NULL,
    `grant_amount` DECIMAL(19,4) NOT NULL DEFAULT 0,
    `grant_start_date` DATETIME NOT NULL,
    `grant_end_date` DATETIME NOT NULL,
    `other_details` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`grant_id`),
    FOREIGN KEY (`organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Documents`;
CREATE TABLE `tracking_grants_for_research`.`Documents` (
    `document_id` INTEGER,
    `document_type_code` VARCHAR(10),
    `grant_id` INTEGER NOT NULL,
    `sent_date` DATETIME NOT NULL,
    `response_received_date` DATETIME NOT NULL,
    `other_details` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`document_id`),
    FOREIGN KEY (`grant_id`) REFERENCES `tracking_grants_for_research`.`Grants` (`grant_id`),
    FOREIGN KEY (`document_type_code`) REFERENCES `tracking_grants_for_research`.`Document_Types` (`document_type_code`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Research_Outcomes`;
CREATE TABLE `tracking_grants_for_research`.`Research_Outcomes` (
    `outcome_code` VARCHAR(10),
    `outcome_description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`outcome_code`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Research_Staff`;
CREATE TABLE `tracking_grants_for_research`.`Research_Staff` (
    `staff_id` INTEGER,
    `employer_organisation_id` INTEGER NOT NULL,
    `staff_details` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`staff_id`),
    FOREIGN KEY (`employer_organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Staff_Roles`;
CREATE TABLE `tracking_grants_for_research`.`Staff_Roles` (
    `role_code` VARCHAR(10),
    `role_description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`role_code`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Projects`;
CREATE TABLE `tracking_grants_for_research`.`Projects` (
    `project_id` INTEGER,
    `organisation_id` INTEGER NOT NULL,
    `project_details` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`project_id`),
    FOREIGN KEY (`organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Project_Outcomes`;
CREATE TABLE `tracking_grants_for_research`.`Project_Outcomes` (
    `project_id` INTEGER NOT NULL,
    `outcome_code` VARCHAR(10) NOT NULL,
    `outcome_details` VARCHAR(255),
    FOREIGN KEY (`outcome_code`) REFERENCES `tracking_grants_for_research`.`Research_Outcomes` (`outcome_code`),
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Project_Staff`;
CREATE TABLE `tracking_grants_for_research`.`Project_Staff` (
    `staff_id` DOUBLE,
    `project_id` INTEGER NOT NULL,
    `role_code` VARCHAR(10) NOT NULL,
    `date_from` DATETIME,
    `date_to` DATETIME,
    `other_details` VARCHAR(255),
    PRIMARY KEY (`staff_id`),
    FOREIGN KEY (`role_code`) REFERENCES `tracking_grants_for_research`.`Staff_Roles` (`role_code`),
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`)
);

DROP TABLE IF EXISTS `tracking_grants_for_research`.`Tasks`;
CREATE TABLE `tracking_grants_for_research`.`Tasks` (
    `task_id` INTEGER,
    `project_id` INTEGER NOT NULL,
    `task_details` VARCHAR(255) NOT NULL,
    `eg Agree Objectives` VARCHAR(1),
    PRIMARY KEY (`task_id`),
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`)
);
