-- Dialect: MySQL | Database: assets_maintenance | Table Count: 14

CREATE DATABASE IF NOT EXISTS `assets_maintenance`;

DROP TABLE IF EXISTS `assets_maintenance`.`Third_Party_Companies`;
CREATE TABLE `assets_maintenance`.`Third_Party_Companies` (
    `company_id` INTEGER,
    `company_type` VARCHAR(5) NOT NULL,
    `company_name` VARCHAR(255),
    `company_address` VARCHAR(255),
    `other_company_details` VARCHAR(255),
    PRIMARY KEY (`company_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Maintenance_Contracts`;
CREATE TABLE `assets_maintenance`.`Maintenance_Contracts` (
    `maintenance_contract_id` INTEGER,
    `maintenance_contract_company_id` INTEGER NOT NULL,
    `contract_start_date` DATETIME,
    `contract_end_date` DATETIME,
    `other_contract_details` VARCHAR(255),
    PRIMARY KEY (`maintenance_contract_id`),
    FOREIGN KEY (`maintenance_contract_company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Parts`;
CREATE TABLE `assets_maintenance`.`Parts` (
    `part_id` INTEGER,
    `part_name` VARCHAR(255),
    `chargeable_yn` VARCHAR(1),
    `chargeable_amount` VARCHAR(20),
    `other_part_details` VARCHAR(255),
    PRIMARY KEY (`part_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Skills`;
CREATE TABLE `assets_maintenance`.`Skills` (
    `skill_id` INTEGER,
    `skill_code` VARCHAR(20),
    `skill_description` VARCHAR(255),
    PRIMARY KEY (`skill_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Staff`;
CREATE TABLE `assets_maintenance`.`Staff` (
    `staff_id` INTEGER,
    `staff_name` VARCHAR(255),
    `gender` VARCHAR(1),
    `other_staff_details` VARCHAR(255),
    PRIMARY KEY (`staff_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Assets`;
CREATE TABLE `assets_maintenance`.`Assets` (
    `asset_id` INTEGER,
    `maintenance_contract_id` INTEGER NOT NULL,
    `supplier_company_id` INTEGER NOT NULL,
    `asset_details` VARCHAR(255),
    `asset_make` VARCHAR(20),
    `asset_model` VARCHAR(20),
    `asset_acquired_date` DATETIME,
    `asset_disposed_date` DATETIME,
    `other_asset_details` VARCHAR(255),
    PRIMARY KEY (`asset_id`),
    FOREIGN KEY (`supplier_company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`),
    FOREIGN KEY (`maintenance_contract_id`) REFERENCES `assets_maintenance`.`Maintenance_Contracts` (`maintenance_contract_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Asset_Parts`;
CREATE TABLE `assets_maintenance`.`Asset_Parts` (
    `asset_id` INTEGER NOT NULL,
    `part_id` INTEGER NOT NULL,
    FOREIGN KEY (`asset_id`) REFERENCES `assets_maintenance`.`Assets` (`asset_id`),
    FOREIGN KEY (`part_id`) REFERENCES `assets_maintenance`.`Parts` (`part_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Maintenance_Engineers`;
CREATE TABLE `assets_maintenance`.`Maintenance_Engineers` (
    `engineer_id` INTEGER,
    `company_id` INTEGER NOT NULL,
    `first_name` VARCHAR(50),
    `last_name` VARCHAR(50),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`engineer_id`),
    FOREIGN KEY (`company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Engineer_Skills`;
CREATE TABLE `assets_maintenance`.`Engineer_Skills` (
    `engineer_id` INTEGER NOT NULL,
    `skill_id` INTEGER NOT NULL,
    FOREIGN KEY (`skill_id`) REFERENCES `assets_maintenance`.`Skills` (`skill_id`),
    FOREIGN KEY (`engineer_id`) REFERENCES `assets_maintenance`.`Maintenance_Engineers` (`engineer_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Fault_Log`;
CREATE TABLE `assets_maintenance`.`Fault_Log` (
    `fault_log_entry_id` INTEGER,
    `asset_id` INTEGER NOT NULL,
    `recorded_by_staff_id` INTEGER NOT NULL,
    `fault_log_entry_datetime` DATETIME,
    `fault_description` VARCHAR(255),
    `other_fault_details` VARCHAR(255),
    PRIMARY KEY (`fault_log_entry_id`),
    FOREIGN KEY (`recorded_by_staff_id`) REFERENCES `assets_maintenance`.`Staff` (`staff_id`),
    FOREIGN KEY (`asset_id`) REFERENCES `assets_maintenance`.`Assets` (`asset_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Engineer_Visits`;
CREATE TABLE `assets_maintenance`.`Engineer_Visits` (
    `engineer_visit_id` INTEGER,
    `contact_staff_id` INTEGER,
    `engineer_id` INTEGER NOT NULL,
    `fault_log_entry_id` INTEGER NOT NULL,
    `fault_status` VARCHAR(10) NOT NULL,
    `visit_start_datetime` DATETIME,
    `visit_end_datetime` DATETIME,
    `other_visit_details` VARCHAR(255),
    PRIMARY KEY (`engineer_visit_id`),
    FOREIGN KEY (`contact_staff_id`) REFERENCES `assets_maintenance`.`Staff` (`staff_id`),
    FOREIGN KEY (`engineer_id`) REFERENCES `assets_maintenance`.`Maintenance_Engineers` (`engineer_id`),
    FOREIGN KEY (`fault_log_entry_id`) REFERENCES `assets_maintenance`.`Fault_Log` (`fault_log_entry_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Part_Faults`;
CREATE TABLE `assets_maintenance`.`Part_Faults` (
    `part_fault_id` INTEGER,
    `part_id` INTEGER NOT NULL,
    `fault_short_name` VARCHAR(20),
    `fault_description` VARCHAR(255),
    `other_fault_details` VARCHAR(255),
    PRIMARY KEY (`part_fault_id`),
    FOREIGN KEY (`part_id`) REFERENCES `assets_maintenance`.`Parts` (`part_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Fault_Log_Parts`;
CREATE TABLE `assets_maintenance`.`Fault_Log_Parts` (
    `fault_log_entry_id` INTEGER NOT NULL,
    `part_fault_id` INTEGER NOT NULL,
    `fault_status` VARCHAR(10) NOT NULL,
    FOREIGN KEY (`fault_log_entry_id`) REFERENCES `assets_maintenance`.`Fault_Log` (`fault_log_entry_id`),
    FOREIGN KEY (`part_fault_id`) REFERENCES `assets_maintenance`.`Part_Faults` (`part_fault_id`)
);

DROP TABLE IF EXISTS `assets_maintenance`.`Skills_Required_To_Fix`;
CREATE TABLE `assets_maintenance`.`Skills_Required_To_Fix` (
    `part_fault_id` INTEGER NOT NULL,
    `skill_id` INTEGER NOT NULL,
    FOREIGN KEY (`skill_id`) REFERENCES `assets_maintenance`.`Skills` (`skill_id`),
    FOREIGN KEY (`part_fault_id`) REFERENCES `assets_maintenance`.`Part_Faults` (`part_fault_id`)
);
