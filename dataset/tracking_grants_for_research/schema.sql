CREATE DATABASE IF NOT EXISTS `tracking_grants_for_research`;

drop table if exists `tracking_grants_for_research`.`Document_Types`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Document_Types` (
    `document_type_code` STRING,
    `document_description` STRING NOT NULL,
    PRIMARY KEY (`document_type_code`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Organisation_Types`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Organisation_Types` (
    `organisation_type` STRING,
    `organisation_type_description` STRING NOT NULL,
    PRIMARY KEY (`organisation_type`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Organisations`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Organisations` (
    `organisation_id` INT,
    `organisation_type` STRING NOT NULL,
    `organisation_details` STRING NOT NULL,
    PRIMARY KEY (`organisation_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organisation_type`) REFERENCES `tracking_grants_for_research`.`Organisation_Types` (`organisation_type`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Grants`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Grants` (
    `grant_id` INT,
    `organisation_id` INT NOT NULL,
    `grant_amount` DECIMAL(19,4) NOT NULL,
    `grant_start_date` TIMESTAMP NOT NULL,
    `grant_end_date` TIMESTAMP NOT NULL,
    `other_details` STRING NOT NULL,
    PRIMARY KEY (`grant_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Documents`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Documents` (
    `document_id` INT,
    `document_type_code` STRING,
    `grant_id` INT NOT NULL,
    `sent_date` TIMESTAMP NOT NULL,
    `response_received_date` TIMESTAMP NOT NULL,
    `other_details` STRING NOT NULL,
    PRIMARY KEY (`document_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`grant_id`) REFERENCES `tracking_grants_for_research`.`Grants` (`grant_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_type_code`) REFERENCES `tracking_grants_for_research`.`Document_Types` (`document_type_code`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Research_Outcomes`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Research_Outcomes` (
    `outcome_code` STRING,
    `outcome_description` STRING NOT NULL,
    PRIMARY KEY (`outcome_code`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Research_Staff`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Research_Staff` (
    `staff_id` INT,
    `employer_organisation_id` INT NOT NULL,
    `staff_details` STRING NOT NULL,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`employer_organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Staff_Roles`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Staff_Roles` (
    `role_code` STRING,
    `role_description` STRING NOT NULL,
    PRIMARY KEY (`role_code`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Projects`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Projects` (
    `project_id` INT,
    `organisation_id` INT NOT NULL,
    `project_details` STRING NOT NULL,
    PRIMARY KEY (`project_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Project_Outcomes`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Project_Outcomes` (
    `project_id` INT NOT NULL,
    `outcome_code` STRING NOT NULL,
    `outcome_details` STRING,
    FOREIGN KEY (`outcome_code`) REFERENCES `tracking_grants_for_research`.`Research_Outcomes` (`outcome_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Project_Staff`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Project_Staff` (
    `staff_id` DOUBLE,
    `project_id` INT NOT NULL,
    `role_code` STRING NOT NULL,
    `date_from` TIMESTAMP,
    `date_to` TIMESTAMP,
    `other_details` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`role_code`) REFERENCES `tracking_grants_for_research`.`Staff_Roles` (`role_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`) DISABLE NOVALIDATE
);

drop table if exists `tracking_grants_for_research`.`Tasks`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Tasks` (
    `task_id` INT,
    `project_id` INT NOT NULL,
    `task_details` STRING NOT NULL,
    `eg Agree Objectives` STRING,
    PRIMARY KEY (`task_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`) DISABLE NOVALIDATE
);
