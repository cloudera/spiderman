CREATE DATABASE IF NOT EXISTS `e_government`;

drop table if exists `e_government`.`Addresses`;
CREATE TABLE IF NOT EXISTS `e_government`.`Addresses` (
    `address_id` INT,
    `line_1_number_building` STRING,
    `town_city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Addresses.csv' INTO TABLE `e_government`.`Addresses`;


drop table if exists `e_government`.`Services`;
CREATE TABLE IF NOT EXISTS `e_government`.`Services` (
    `service_id` INT,
    `service_type_code` STRING NOT NULL,
    `service_name` STRING,
    `service_descriptio` STRING,
    PRIMARY KEY (`service_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Services.csv' INTO TABLE `e_government`.`Services`;


drop table if exists `e_government`.`Forms`;
CREATE TABLE IF NOT EXISTS `e_government`.`Forms` (
    `form_id` INT,
    `form_type_code` STRING NOT NULL,
    `service_id` INT,
    `form_number` STRING,
    `form_name` STRING,
    `form_description` STRING,
    PRIMARY KEY (`form_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`service_id`) REFERENCES `e_government`.`Services` (`service_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Forms.csv' INTO TABLE `e_government`.`Forms`;


drop table if exists `e_government`.`Individuals`;
CREATE TABLE IF NOT EXISTS `e_government`.`Individuals` (
    `individual_id` INT,
    `individual_first_name` STRING,
    `individual_middle_name` STRING,
    `inidividual_phone` STRING,
    `individual_email` STRING,
    `individual_address` STRING,
    `individual_last_name` STRING,
    PRIMARY KEY (`individual_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Individuals.csv' INTO TABLE `e_government`.`Individuals`;


drop table if exists `e_government`.`Organizations`;
CREATE TABLE IF NOT EXISTS `e_government`.`Organizations` (
    `organization_id` INT,
    `date_formed` TIMESTAMP,
    `organization_name` STRING,
    `uk_vat_number` STRING,
    PRIMARY KEY (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Organizations.csv' INTO TABLE `e_government`.`Organizations`;


drop table if exists `e_government`.`Parties`;
CREATE TABLE IF NOT EXISTS `e_government`.`Parties` (
    `party_id` INT,
    `payment_method_code` STRING NOT NULL,
    `party_phone` STRING,
    `party_email` STRING,
    PRIMARY KEY (`party_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Parties.csv' INTO TABLE `e_government`.`Parties`;


drop table if exists `e_government`.`Organization_Contact_Individuals`;
CREATE TABLE IF NOT EXISTS `e_government`.`Organization_Contact_Individuals` (
    `individual_id` INT NOT NULL,
    `organization_id` INT NOT NULL,
    `date_contact_from` TIMESTAMP NOT NULL,
    `date_contact_to` TIMESTAMP,
    PRIMARY KEY (`individual_id`, `organization_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`individual_id`) REFERENCES `e_government`.`Individuals` (`individual_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organization_id`) REFERENCES `e_government`.`Organizations` (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Organization_Contact_Individuals.csv' INTO TABLE `e_government`.`Organization_Contact_Individuals`;


drop table if exists `e_government`.`Party_Addresses`;
CREATE TABLE IF NOT EXISTS `e_government`.`Party_Addresses` (
    `party_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_address_from` TIMESTAMP NOT NULL,
    `address_type_code` STRING NOT NULL,
    `date_address_to` TIMESTAMP,
    PRIMARY KEY (`party_id`, `address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`party_id`) REFERENCES `e_government`.`Parties` (`party_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `e_government`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Party_Addresses.csv' INTO TABLE `e_government`.`Party_Addresses`;


drop table if exists `e_government`.`Party_Forms`;
CREATE TABLE IF NOT EXISTS `e_government`.`Party_Forms` (
    `party_id` INT NOT NULL,
    `form_id` INT NOT NULL,
    `date_completion_started` TIMESTAMP NOT NULL,
    `form_status_code` STRING NOT NULL,
    `date_fully_completed` TIMESTAMP,
    PRIMARY KEY (`party_id`, `form_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`form_id`) REFERENCES `e_government`.`Forms` (`form_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`party_id`) REFERENCES `e_government`.`Parties` (`party_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Party_Forms.csv' INTO TABLE `e_government`.`Party_Forms`;


drop table if exists `e_government`.`Party_Services`;
CREATE TABLE IF NOT EXISTS `e_government`.`Party_Services` (
    `booking_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `service_id` INT NOT NULL,
    `service_datetime` TIMESTAMP NOT NULL,
    `booking_made_date` TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `e_government`.`Parties` (`party_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`service_id`) REFERENCES `e_government`.`Services` (`service_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Party_Services.csv' INTO TABLE `e_government`.`Party_Services`;

