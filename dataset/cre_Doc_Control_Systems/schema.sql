CREATE DATABASE IF NOT EXISTS `cre_Doc_Control_Systems`;

drop table if exists `cre_Doc_Control_Systems`.`Ref_Document_Types`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Ref_Document_Types` (
    `document_type_code` CHAR(15) NOT NULL,
    `document_type_description` STRING NOT NULL,
    PRIMARY KEY (`document_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Ref_Document_Types.csv' INTO TABLE `cre_Doc_Control_Systems`.`Ref_Document_Types`;


drop table if exists `cre_Doc_Control_Systems`.`Roles`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Roles` (
    `role_code` CHAR(15) NOT NULL,
    `role_description` STRING,
    PRIMARY KEY (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Roles.csv' INTO TABLE `cre_Doc_Control_Systems`.`Roles`;


drop table if exists `cre_Doc_Control_Systems`.`Addresses`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Addresses` (
    `address_id` INT NOT NULL,
    `address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Addresses.csv' INTO TABLE `cre_Doc_Control_Systems`.`Addresses`;


drop table if exists `cre_Doc_Control_Systems`.`Ref_Document_Status`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Ref_Document_Status` (
    `document_status_code` CHAR(15) NOT NULL,
    `document_status_description` STRING NOT NULL,
    PRIMARY KEY (`document_status_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Ref_Document_Status.csv' INTO TABLE `cre_Doc_Control_Systems`.`Ref_Document_Status`;


drop table if exists `cre_Doc_Control_Systems`.`Ref_Shipping_Agents`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Ref_Shipping_Agents` (
    `shipping_agent_code` CHAR(15) NOT NULL,
    `shipping_agent_name` STRING NOT NULL,
    `shipping_agent_description` STRING NOT NULL,
    PRIMARY KEY (`shipping_agent_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Ref_Shipping_Agents.csv' INTO TABLE `cre_Doc_Control_Systems`.`Ref_Shipping_Agents`;


drop table if exists `cre_Doc_Control_Systems`.`Documents`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Documents` (
    `document_id` INT NOT NULL,
    `document_status_code` CHAR(15) NOT NULL,
    `document_type_code` CHAR(15) NOT NULL,
    `shipping_agent_code` CHAR(15),
    `receipt_date` TIMESTAMP,
    `receipt_number` STRING,
    `other_details` STRING,
    PRIMARY KEY (`document_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`shipping_agent_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Shipping_Agents` (`shipping_agent_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_status_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Document_Status` (`document_status_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_type_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Document_Types` (`document_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Documents.csv' INTO TABLE `cre_Doc_Control_Systems`.`Documents`;


drop table if exists `cre_Doc_Control_Systems`.`Employees`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Employees` (
    `employee_id` INT NOT NULL,
    `role_code` CHAR(15) NOT NULL,
    `employee_name` STRING,
    `other_details` STRING,
    PRIMARY KEY (`employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`role_code`) REFERENCES `cre_Doc_Control_Systems`.`Roles` (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Employees.csv' INTO TABLE `cre_Doc_Control_Systems`.`Employees`;


drop table if exists `cre_Doc_Control_Systems`.`Document_Drafts`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Document_Drafts` (
    `document_id` INT NOT NULL,
    `draft_number` INT NOT NULL,
    `draft_details` STRING,
    PRIMARY KEY (`document_id`, `draft_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_id`) REFERENCES `cre_Doc_Control_Systems`.`Documents` (`document_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Document_Drafts.csv' INTO TABLE `cre_Doc_Control_Systems`.`Document_Drafts`;


drop table if exists `cre_Doc_Control_Systems`.`Draft_Copies`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Draft_Copies` (
    `document_id` INT NOT NULL,
    `draft_number` INT NOT NULL,
    `copy_number` INT NOT NULL,
    PRIMARY KEY (`document_id`, `draft_number`, `copy_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_id`, `draft_number`) REFERENCES `cre_Doc_Control_Systems`.`Document_Drafts` (`document_id`, `draft_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Draft_Copies.csv' INTO TABLE `cre_Doc_Control_Systems`.`Draft_Copies`;


drop table if exists `cre_Doc_Control_Systems`.`Circulation_History`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Circulation_History` (
    `document_id` INT NOT NULL,
    `draft_number` INT NOT NULL,
    `copy_number` INT NOT NULL,
    `employee_id` INT NOT NULL,
    PRIMARY KEY (`document_id`, `draft_number`, `copy_number`, `employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`employee_id`) REFERENCES `cre_Doc_Control_Systems`.`Employees` (`employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_id`, `draft_number`, `copy_number`) REFERENCES `cre_Doc_Control_Systems`.`Draft_Copies` (`document_id`, `draft_number`, `copy_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Circulation_History.csv' INTO TABLE `cre_Doc_Control_Systems`.`Circulation_History`;


drop table if exists `cre_Doc_Control_Systems`.`Documents_Mailed`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Documents_Mailed` (
    `document_id` INT NOT NULL,
    `mailed_to_address_id` INT NOT NULL,
    `mailing_date` TIMESTAMP,
    PRIMARY KEY (`document_id`, `mailed_to_address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`mailed_to_address_id`) REFERENCES `cre_Doc_Control_Systems`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_id`) REFERENCES `cre_Doc_Control_Systems`.`Documents` (`document_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Documents_Mailed.csv' INTO TABLE `cre_Doc_Control_Systems`.`Documents_Mailed`;

