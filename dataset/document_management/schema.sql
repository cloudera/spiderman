CREATE DATABASE IF NOT EXISTS `document_management`;

drop table if exists `document_management`.`Roles`;
CREATE TABLE IF NOT EXISTS `document_management`.`Roles` (
    `role_code` STRING,
    `role_description` STRING,
    PRIMARY KEY (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Roles.csv' INTO TABLE `document_management`.`Roles`;


drop table if exists `document_management`.`Users`;
CREATE TABLE IF NOT EXISTS `document_management`.`Users` (
    `user_id` INT,
    `role_code` STRING NOT NULL,
    `user_name` STRING,
    `user_login` STRING,
    `password` STRING,
    PRIMARY KEY (`user_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`role_code`) REFERENCES `document_management`.`Roles` (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Users.csv' INTO TABLE `document_management`.`Users`;


drop table if exists `document_management`.`Document_Structures`;
CREATE TABLE IF NOT EXISTS `document_management`.`Document_Structures` (
    `document_structure_code` STRING,
    `parent_document_structure_code` STRING,
    `document_structure_description` STRING,
    PRIMARY KEY (`document_structure_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Document_Structures.csv' INTO TABLE `document_management`.`Document_Structures`;


drop table if exists `document_management`.`Functional_Areas`;
CREATE TABLE IF NOT EXISTS `document_management`.`Functional_Areas` (
    `functional_area_code` STRING,
    `parent_functional_area_code` STRING,
    `functional_area_description` STRING NOT NULL,
    PRIMARY KEY (`functional_area_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Functional_Areas.csv' INTO TABLE `document_management`.`Functional_Areas`;


drop table if exists `document_management`.`Images`;
CREATE TABLE IF NOT EXISTS `document_management`.`Images` (
    `image_id` INT,
    `image_alt_text` STRING,
    `image_name` STRING,
    `image_url` STRING,
    PRIMARY KEY (`image_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Images.csv' INTO TABLE `document_management`.`Images`;


drop table if exists `document_management`.`Documents`;
CREATE TABLE IF NOT EXISTS `document_management`.`Documents` (
    `document_code` STRING,
    `document_structure_code` STRING NOT NULL,
    `document_type_code` STRING NOT NULL,
    `access_count` INT,
    `document_name` STRING,
    PRIMARY KEY (`document_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_structure_code`) REFERENCES `document_management`.`Document_Structures` (`document_structure_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Documents.csv' INTO TABLE `document_management`.`Documents`;


drop table if exists `document_management`.`Document_Functional_Areas`;
CREATE TABLE IF NOT EXISTS `document_management`.`Document_Functional_Areas` (
    `document_code` STRING NOT NULL,
    `functional_area_code` STRING NOT NULL,
    FOREIGN KEY (`functional_area_code`) REFERENCES `document_management`.`Functional_Areas` (`functional_area_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_code`) REFERENCES `document_management`.`Documents` (`document_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Document_Functional_Areas.csv' INTO TABLE `document_management`.`Document_Functional_Areas`;


drop table if exists `document_management`.`Document_Sections`;
CREATE TABLE IF NOT EXISTS `document_management`.`Document_Sections` (
    `section_id` INT,
    `document_code` STRING NOT NULL,
    `section_sequence` INT,
    `section_code` STRING,
    `section_title` STRING,
    PRIMARY KEY (`section_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_code`) REFERENCES `document_management`.`Documents` (`document_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Document_Sections.csv' INTO TABLE `document_management`.`Document_Sections`;


drop table if exists `document_management`.`Document_Sections_Images`;
CREATE TABLE IF NOT EXISTS `document_management`.`Document_Sections_Images` (
    `section_id` INT NOT NULL,
    `image_id` INT NOT NULL,
    PRIMARY KEY (`section_id`, `image_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`image_id`) REFERENCES `document_management`.`Images` (`image_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`section_id`) REFERENCES `document_management`.`Document_Sections` (`section_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Document_Sections_Images.csv' INTO TABLE `document_management`.`Document_Sections_Images`;

