drop table if exists `local_govt_and_lot`.`Customers`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Customers` (
    `customer_id` INT NOT NULL,
    `customer_details` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Customers.csv' INTO TABLE `local_govt_and_lot`.`Customers`;


drop table if exists `local_govt_and_lot`.`Properties`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Properties` (
    `property_id` INT NOT NULL,
    `property_type_code` CHAR(15) NOT NULL,
    `property_address` STRING,
    `other_details` STRING,
    PRIMARY KEY (`property_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Properties.csv' INTO TABLE `local_govt_and_lot`.`Properties`;


drop table if exists `local_govt_and_lot`.`Residents`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Residents` (
    `resident_id` INT NOT NULL,
    `property_id` INT NOT NULL,
    `date_moved_in` TIMESTAMP NOT NULL,
    `date_moved_out` TIMESTAMP NOT NULL,
    `other_details` STRING,
    PRIMARY KEY (`resident_id`, `property_id`, `date_moved_in`) DISABLE NOVALIDATE,
    FOREIGN KEY (`property_id`) REFERENCES `local_govt_and_lot`.`Properties` (`property_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Residents.csv' INTO TABLE `local_govt_and_lot`.`Residents`;


drop table if exists `local_govt_and_lot`.`Organizations`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Organizations` (
    `organization_id` INT NOT NULL,
    `parent_organization_id` INT,
    `organization_details` STRING,
    PRIMARY KEY (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Organizations.csv' INTO TABLE `local_govt_and_lot`.`Organizations`;


drop table if exists `local_govt_and_lot`.`Services`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Services` (
    `service_id` INT NOT NULL,
    `organization_id` INT NOT NULL,
    `service_type_code` CHAR(15) NOT NULL,
    `service_details` STRING,
    PRIMARY KEY (`service_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organization_id`) REFERENCES `local_govt_and_lot`.`Organizations` (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Services.csv' INTO TABLE `local_govt_and_lot`.`Services`;


drop table if exists `local_govt_and_lot`.`Residents_Services`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Residents_Services` (
    `resident_id` INT NOT NULL,
    `service_id` INT NOT NULL,
    `date_moved_in` TIMESTAMP,
    `property_id` INT,
    `date_requested` TIMESTAMP,
    `date_provided` TIMESTAMP,
    `other_details` STRING,
    PRIMARY KEY (`resident_id`, `service_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`resident_id`, `property_id`, `date_moved_in`) REFERENCES `local_govt_and_lot`.`Residents` (`resident_id`, `property_id`, `date_moved_in`) DISABLE NOVALIDATE,
    FOREIGN KEY (`service_id`) REFERENCES `local_govt_and_lot`.`Services` (`service_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Residents_Services.csv' INTO TABLE `local_govt_and_lot`.`Residents_Services`;


drop table if exists `local_govt_and_lot`.`Things`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Things` (
    `thing_id` INT NOT NULL,
    `organization_id` INT NOT NULL,
    `Type_of_Thing_Code` CHAR(15) NOT NULL,
    `service_type_code` CHAR(10) NOT NULL,
    `service_details` STRING,
    PRIMARY KEY (`thing_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organization_id`) REFERENCES `local_govt_and_lot`.`Organizations` (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Things.csv' INTO TABLE `local_govt_and_lot`.`Things`;


drop table if exists `local_govt_and_lot`.`Customer_Events`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Customer_Events` (
    `Customer_Event_ID` INT NOT NULL,
    `customer_id` INT,
    `date_moved_in` TIMESTAMP,
    `property_id` INT,
    `resident_id` INT,
    `thing_id` INT NOT NULL,
    PRIMARY KEY (`Customer_Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`resident_id`, `property_id`, `date_moved_in`) REFERENCES `local_govt_and_lot`.`Residents` (`resident_id`, `property_id`, `date_moved_in`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `local_govt_and_lot`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Customer_Events.csv' INTO TABLE `local_govt_and_lot`.`Customer_Events`;


drop table if exists `local_govt_and_lot`.`Customer_Event_Notes`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Customer_Event_Notes` (
    `Customer_Event_Note_ID` INT NOT NULL,
    `Customer_Event_ID` INT NOT NULL,
    `service_type_code` CHAR(15) NOT NULL,
    `resident_id` INT NOT NULL,
    `property_id` INT NOT NULL,
    `date_moved_in` TIMESTAMP NOT NULL,
    PRIMARY KEY (`Customer_Event_Note_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_Event_ID`) REFERENCES `local_govt_and_lot`.`Customer_Events` (`Customer_Event_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Customer_Event_Notes.csv' INTO TABLE `local_govt_and_lot`.`Customer_Event_Notes`;


drop table if exists `local_govt_and_lot`.`Timed_Status_of_Things`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Timed_Status_of_Things` (
    `thing_id` INT NOT NULL,
    `Date_and_Date` TIMESTAMP NOT NULL,
    `Status_of_Thing_Code` CHAR(15) NOT NULL,
    PRIMARY KEY (`thing_id`, `Date_and_Date`, `Status_of_Thing_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Timed_Status_of_Things.csv' INTO TABLE `local_govt_and_lot`.`Timed_Status_of_Things`;


drop table if exists `local_govt_and_lot`.`Timed_Locations_of_Things`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Timed_Locations_of_Things` (
    `thing_id` INT NOT NULL,
    `Date_and_Time` TIMESTAMP NOT NULL,
    `Location_Code` CHAR(15) NOT NULL,
    PRIMARY KEY (`thing_id`, `Date_and_Time`, `Location_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Timed_Locations_of_Things.csv' INTO TABLE `local_govt_and_lot`.`Timed_Locations_of_Things`;

