CREATE DATABASE IF NOT EXISTS `assets_maintenance`;

drop table if exists `assets_maintenance`.`Third_Party_Companies`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Third_Party_Companies` (
    `company_id` INT,
    `company_type` STRING NOT NULL,
    `company_name` STRING,
    `company_address` STRING,
    `other_company_details` STRING,
    PRIMARY KEY (`company_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Third_Party_Companies.csv' INTO TABLE `assets_maintenance`.`Third_Party_Companies`;


drop table if exists `assets_maintenance`.`Maintenance_Contracts`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Maintenance_Contracts` (
    `maintenance_contract_id` INT,
    `maintenance_contract_company_id` INT NOT NULL,
    `contract_start_date` TIMESTAMP,
    `contract_end_date` TIMESTAMP,
    `other_contract_details` STRING,
    PRIMARY KEY (`maintenance_contract_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`maintenance_contract_company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Maintenance_Contracts.csv' INTO TABLE `assets_maintenance`.`Maintenance_Contracts`;


drop table if exists `assets_maintenance`.`Parts`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Parts` (
    `part_id` INT,
    `part_name` STRING,
    `chargeable_yn` STRING,
    `chargeable_amount` STRING,
    `other_part_details` STRING,
    PRIMARY KEY (`part_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Parts.csv' INTO TABLE `assets_maintenance`.`Parts`;


drop table if exists `assets_maintenance`.`Skills`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Skills` (
    `skill_id` INT,
    `skill_code` STRING,
    `skill_description` STRING,
    PRIMARY KEY (`skill_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Skills.csv' INTO TABLE `assets_maintenance`.`Skills`;


drop table if exists `assets_maintenance`.`Staff`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Staff` (
    `staff_id` INT,
    `staff_name` STRING,
    `gender` STRING,
    `other_staff_details` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Staff.csv' INTO TABLE `assets_maintenance`.`Staff`;


drop table if exists `assets_maintenance`.`Assets`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Assets` (
    `asset_id` INT,
    `maintenance_contract_id` INT NOT NULL,
    `supplier_company_id` INT NOT NULL,
    `asset_details` STRING,
    `asset_make` STRING,
    `asset_model` STRING,
    `asset_acquired_date` TIMESTAMP,
    `asset_disposed_date` TIMESTAMP,
    `other_asset_details` STRING,
    PRIMARY KEY (`asset_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`supplier_company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`maintenance_contract_id`) REFERENCES `assets_maintenance`.`Maintenance_Contracts` (`maintenance_contract_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Assets.csv' INTO TABLE `assets_maintenance`.`Assets`;


drop table if exists `assets_maintenance`.`Asset_Parts`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Asset_Parts` (
    `asset_id` INT NOT NULL,
    `part_id` INT NOT NULL,
    FOREIGN KEY (`asset_id`) REFERENCES `assets_maintenance`.`Assets` (`asset_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`part_id`) REFERENCES `assets_maintenance`.`Parts` (`part_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Asset_Parts.csv' INTO TABLE `assets_maintenance`.`Asset_Parts`;


drop table if exists `assets_maintenance`.`Maintenance_Engineers`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Maintenance_Engineers` (
    `engineer_id` INT,
    `company_id` INT NOT NULL,
    `first_name` STRING,
    `last_name` STRING,
    `other_details` STRING,
    PRIMARY KEY (`engineer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Maintenance_Engineers.csv' INTO TABLE `assets_maintenance`.`Maintenance_Engineers`;


drop table if exists `assets_maintenance`.`Engineer_Skills`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Engineer_Skills` (
    `engineer_id` INT NOT NULL,
    `skill_id` INT NOT NULL,
    FOREIGN KEY (`skill_id`) REFERENCES `assets_maintenance`.`Skills` (`skill_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`engineer_id`) REFERENCES `assets_maintenance`.`Maintenance_Engineers` (`engineer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Engineer_Skills.csv' INTO TABLE `assets_maintenance`.`Engineer_Skills`;


drop table if exists `assets_maintenance`.`Fault_Log`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Fault_Log` (
    `fault_log_entry_id` INT,
    `asset_id` INT NOT NULL,
    `recorded_by_staff_id` INT NOT NULL,
    `fault_log_entry_datetime` TIMESTAMP,
    `fault_description` STRING,
    `other_fault_details` STRING,
    PRIMARY KEY (`fault_log_entry_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`recorded_by_staff_id`) REFERENCES `assets_maintenance`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`asset_id`) REFERENCES `assets_maintenance`.`Assets` (`asset_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Fault_Log.csv' INTO TABLE `assets_maintenance`.`Fault_Log`;


drop table if exists `assets_maintenance`.`Engineer_Visits`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Engineer_Visits` (
    `engineer_visit_id` INT,
    `contact_staff_id` INT,
    `engineer_id` INT NOT NULL,
    `fault_log_entry_id` INT NOT NULL,
    `fault_status` STRING NOT NULL,
    `visit_start_datetime` TIMESTAMP,
    `visit_end_datetime` TIMESTAMP,
    `other_visit_details` STRING,
    PRIMARY KEY (`engineer_visit_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`contact_staff_id`) REFERENCES `assets_maintenance`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`engineer_id`) REFERENCES `assets_maintenance`.`Maintenance_Engineers` (`engineer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`fault_log_entry_id`) REFERENCES `assets_maintenance`.`Fault_Log` (`fault_log_entry_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Engineer_Visits.csv' INTO TABLE `assets_maintenance`.`Engineer_Visits`;


drop table if exists `assets_maintenance`.`Part_Faults`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Part_Faults` (
    `part_fault_id` INT,
    `part_id` INT NOT NULL,
    `fault_short_name` STRING,
    `fault_description` STRING,
    `other_fault_details` STRING,
    PRIMARY KEY (`part_fault_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`part_id`) REFERENCES `assets_maintenance`.`Parts` (`part_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Part_Faults.csv' INTO TABLE `assets_maintenance`.`Part_Faults`;


drop table if exists `assets_maintenance`.`Fault_Log_Parts`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Fault_Log_Parts` (
    `fault_log_entry_id` INT NOT NULL,
    `part_fault_id` INT NOT NULL,
    `fault_status` STRING NOT NULL,
    FOREIGN KEY (`fault_log_entry_id`) REFERENCES `assets_maintenance`.`Fault_Log` (`fault_log_entry_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`part_fault_id`) REFERENCES `assets_maintenance`.`Part_Faults` (`part_fault_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Fault_Log_Parts.csv' INTO TABLE `assets_maintenance`.`Fault_Log_Parts`;


drop table if exists `assets_maintenance`.`Skills_Required_To_Fix`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Skills_Required_To_Fix` (
    `part_fault_id` INT NOT NULL,
    `skill_id` INT NOT NULL,
    FOREIGN KEY (`skill_id`) REFERENCES `assets_maintenance`.`Skills` (`skill_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`part_fault_id`) REFERENCES `assets_maintenance`.`Part_Faults` (`part_fault_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Skills_Required_To_Fix.csv' INTO TABLE `assets_maintenance`.`Skills_Required_To_Fix`;

