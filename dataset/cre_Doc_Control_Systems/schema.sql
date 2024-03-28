-- Dialect: MySQL | Database: cre_Doc_Control_Systems | Table Count: 11

CREATE DATABASE IF NOT EXISTS `cre_Doc_Control_Systems`;

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Ref_Document_Types`;
CREATE TABLE `cre_Doc_Control_Systems`.`Ref_Document_Types` (
    `document_type_code` CHAR(15) NOT NULL,
    `document_type_description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`document_type_code`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Roles`;
CREATE TABLE `cre_Doc_Control_Systems`.`Roles` (
    `role_code` CHAR(15) NOT NULL,
    `role_description` VARCHAR(255),
    PRIMARY KEY (`role_code`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Addresses`;
CREATE TABLE `cre_Doc_Control_Systems`.`Addresses` (
    `address_id` INTEGER NOT NULL,
    `address_details` VARCHAR(255),
    PRIMARY KEY (`address_id`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Ref_Document_Status`;
CREATE TABLE `cre_Doc_Control_Systems`.`Ref_Document_Status` (
    `document_status_code` CHAR(15) NOT NULL,
    `document_status_description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`document_status_code`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Ref_Shipping_Agents`;
CREATE TABLE `cre_Doc_Control_Systems`.`Ref_Shipping_Agents` (
    `shipping_agent_code` CHAR(15) NOT NULL,
    `shipping_agent_name` VARCHAR(255) NOT NULL,
    `shipping_agent_description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`shipping_agent_code`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Documents`;
CREATE TABLE `cre_Doc_Control_Systems`.`Documents` (
    `document_id` INTEGER NOT NULL,
    `document_status_code` CHAR(15) NOT NULL,
    `document_type_code` CHAR(15) NOT NULL,
    `shipping_agent_code` CHAR(15),
    `receipt_date` DATETIME,
    `receipt_number` VARCHAR(255),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`document_id`),
    FOREIGN KEY (`shipping_agent_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Shipping_Agents` (`shipping_agent_code`),
    FOREIGN KEY (`document_status_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Document_Status` (`document_status_code`),
    FOREIGN KEY (`document_type_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Document_Types` (`document_type_code`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Employees`;
CREATE TABLE `cre_Doc_Control_Systems`.`Employees` (
    `employee_id` INTEGER NOT NULL,
    `role_code` CHAR(15) NOT NULL,
    `employee_name` VARCHAR(255),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`employee_id`),
    FOREIGN KEY (`role_code`) REFERENCES `cre_Doc_Control_Systems`.`Roles` (`role_code`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Document_Drafts`;
CREATE TABLE `cre_Doc_Control_Systems`.`Document_Drafts` (
    `document_id` INTEGER NOT NULL,
    `draft_number` INTEGER NOT NULL,
    `draft_details` VARCHAR(255),
    PRIMARY KEY (`document_id`, `draft_number`),
    FOREIGN KEY (`document_id`) REFERENCES `cre_Doc_Control_Systems`.`Documents` (`document_id`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Draft_Copies`;
CREATE TABLE `cre_Doc_Control_Systems`.`Draft_Copies` (
    `document_id` INTEGER NOT NULL,
    `draft_number` INTEGER NOT NULL,
    `copy_number` INTEGER NOT NULL,
    PRIMARY KEY (`document_id`, `draft_number`, `copy_number`),
    FOREIGN KEY (`document_id`, `draft_number`) REFERENCES `cre_Doc_Control_Systems`.`Document_Drafts` (`document_id`, `draft_number`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Circulation_History`;
CREATE TABLE `cre_Doc_Control_Systems`.`Circulation_History` (
    `document_id` INTEGER NOT NULL,
    `draft_number` INTEGER NOT NULL,
    `copy_number` INTEGER NOT NULL,
    `employee_id` INTEGER NOT NULL,
    PRIMARY KEY (`document_id`, `draft_number`, `copy_number`, `employee_id`),
    FOREIGN KEY (`employee_id`) REFERENCES `cre_Doc_Control_Systems`.`Employees` (`employee_id`),
    FOREIGN KEY (`document_id`, `draft_number`, `copy_number`) REFERENCES `cre_Doc_Control_Systems`.`Draft_Copies` (`document_id`, `draft_number`, `copy_number`)
);

DROP TABLE IF EXISTS `cre_Doc_Control_Systems`.`Documents_Mailed`;
CREATE TABLE `cre_Doc_Control_Systems`.`Documents_Mailed` (
    `document_id` INTEGER NOT NULL,
    `mailed_to_address_id` INTEGER NOT NULL,
    `mailing_date` DATETIME,
    PRIMARY KEY (`document_id`, `mailed_to_address_id`),
    FOREIGN KEY (`mailed_to_address_id`) REFERENCES `cre_Doc_Control_Systems`.`Addresses` (`address_id`),
    FOREIGN KEY (`document_id`) REFERENCES `cre_Doc_Control_Systems`.`Documents` (`document_id`)
);
