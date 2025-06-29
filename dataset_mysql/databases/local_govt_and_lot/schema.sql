-- Dialect: mysql | Database: local_govt_and_lot | Table Count: 11

CREATE TABLE `local_govt_and_lot`.`Customers` (
    `customer_id` INTEGER NOT NULL,
    `customer_details` VARCHAR(255),
    PRIMARY KEY (`customer_id`)
);

CREATE TABLE `local_govt_and_lot`.`Properties` (
    `property_id` INTEGER NOT NULL,
    `property_type_code` CHAR(15) NOT NULL,
    `property_address` VARCHAR(255),
    `other_details` VARCHAR(255),
    PRIMARY KEY (`property_id`)
);

CREATE TABLE `local_govt_and_lot`.`Residents` (
    `resident_id` INTEGER NOT NULL,
    `property_id` INTEGER NOT NULL,
    `date_moved_in` DATETIME NOT NULL,
    `date_moved_out` DATETIME NOT NULL,
    `other_details` VARCHAR(255),
    PRIMARY KEY (`resident_id`, `property_id`, `date_moved_in`),
    FOREIGN KEY (`property_id`) REFERENCES `local_govt_and_lot`.`Properties` (`property_id`)
);

CREATE TABLE `local_govt_and_lot`.`Organizations` (
    `organization_id` INTEGER NOT NULL,
    `parent_organization_id` INTEGER,
    `organization_details` VARCHAR(255),
    PRIMARY KEY (`organization_id`)
);

CREATE TABLE `local_govt_and_lot`.`Services` (
    `service_id` INTEGER NOT NULL,
    `organization_id` INTEGER NOT NULL,
    `service_type_code` CHAR(15) NOT NULL,
    `service_details` VARCHAR(255),
    PRIMARY KEY (`service_id`),
    FOREIGN KEY (`organization_id`) REFERENCES `local_govt_and_lot`.`Organizations` (`organization_id`)
);

CREATE TABLE `local_govt_and_lot`.`Residents_Services` (
    `resident_id` INTEGER NOT NULL,
    `service_id` INTEGER NOT NULL,
    `date_moved_in` DATETIME,
    `property_id` INTEGER,
    `date_requested` DATETIME,
    `date_provided` DATETIME,
    `other_details` VARCHAR(255),
    PRIMARY KEY (`resident_id`, `service_id`),
    FOREIGN KEY (`resident_id`, `property_id`, `date_moved_in`) REFERENCES `local_govt_and_lot`.`Residents` (`resident_id`, `property_id`, `date_moved_in`),
    FOREIGN KEY (`service_id`) REFERENCES `local_govt_and_lot`.`Services` (`service_id`)
);

CREATE TABLE `local_govt_and_lot`.`Things` (
    `thing_id` INTEGER NOT NULL,
    `organization_id` INTEGER NOT NULL,
    `Type_of_Thing_Code` CHAR(15) NOT NULL,
    `service_type_code` CHAR(10) NOT NULL,
    `service_details` VARCHAR(255),
    PRIMARY KEY (`thing_id`),
    FOREIGN KEY (`organization_id`) REFERENCES `local_govt_and_lot`.`Organizations` (`organization_id`)
);

CREATE TABLE `local_govt_and_lot`.`Customer_Events` (
    `Customer_Event_ID` INTEGER NOT NULL,
    `customer_id` INTEGER,
    `date_moved_in` DATETIME,
    `property_id` INTEGER,
    `resident_id` INTEGER,
    `thing_id` INTEGER NOT NULL,
    PRIMARY KEY (`Customer_Event_ID`),
    FOREIGN KEY (`resident_id`, `property_id`, `date_moved_in`) REFERENCES `local_govt_and_lot`.`Residents` (`resident_id`, `property_id`, `date_moved_in`),
    FOREIGN KEY (`customer_id`) REFERENCES `local_govt_and_lot`.`Customers` (`customer_id`),
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`)
);

CREATE TABLE `local_govt_and_lot`.`Customer_Event_Notes` (
    `Customer_Event_Note_ID` INTEGER NOT NULL,
    `Customer_Event_ID` INTEGER NOT NULL,
    `service_type_code` CHAR(15) NOT NULL,
    `resident_id` INTEGER NOT NULL,
    `property_id` INTEGER NOT NULL,
    `date_moved_in` DATETIME NOT NULL,
    PRIMARY KEY (`Customer_Event_Note_ID`),
    FOREIGN KEY (`Customer_Event_ID`) REFERENCES `local_govt_and_lot`.`Customer_Events` (`Customer_Event_ID`)
);

CREATE TABLE `local_govt_and_lot`.`Timed_Status_of_Things` (
    `thing_id` INTEGER NOT NULL,
    `Date_and_Date` DATETIME NOT NULL,
    `Status_of_Thing_Code` CHAR(15) NOT NULL,
    PRIMARY KEY (`thing_id`, `Date_and_Date`, `Status_of_Thing_Code`),
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`)
);

CREATE TABLE `local_govt_and_lot`.`Timed_Locations_of_Things` (
    `thing_id` INTEGER NOT NULL,
    `Date_and_Time` DATETIME NOT NULL,
    `Location_Code` CHAR(15) NOT NULL,
    PRIMARY KEY (`thing_id`, `Date_and_Time`, `Location_Code`),
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`)
);
