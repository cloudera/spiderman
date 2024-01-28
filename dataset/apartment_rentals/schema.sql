CREATE DATABASE IF NOT EXISTS `apartment_rentals`;

drop table if exists `apartment_rentals`.`Apartment_Buildings`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Apartment_Buildings` (
    `building_id` INT NOT NULL,
    `building_short_name` CHAR(15),
    `building_full_name` STRING,
    `building_description` STRING,
    `building_address` STRING,
    `building_manager` STRING,
    `building_phone` STRING,
    PRIMARY KEY (`building_id`) DISABLE NOVALIDATE,
    UNIQUE (`building_id`) DISABLE NOVALIDATE
);

drop table if exists `apartment_rentals`.`Apartments`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Apartments` (
    `apt_id` INT NOT NULL,
    `building_id` INT NOT NULL,
    `apt_type_code` CHAR(15),
    `apt_number` CHAR(10),
    `bathroom_count` INT,
    `bedroom_count` INT,
    `room_count` CHAR(5),
    PRIMARY KEY (`apt_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building_id`) REFERENCES `apartment_rentals`.`Apartment_Buildings` (`building_id`) DISABLE NOVALIDATE,
    UNIQUE (`apt_id`) DISABLE NOVALIDATE
);

drop table if exists `apartment_rentals`.`Apartment_Facilities`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Apartment_Facilities` (
    `apt_id` INT NOT NULL,
    `facility_code` CHAR(15) NOT NULL,
    PRIMARY KEY (`apt_id`, `facility_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`apt_id`) REFERENCES `apartment_rentals`.`Apartments` (`apt_id`) DISABLE NOVALIDATE
);

drop table if exists `apartment_rentals`.`Guests`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Guests` (
    `guest_id` INT NOT NULL,
    `gender_code` CHAR(1),
    `guest_first_name` STRING,
    `guest_last_name` STRING,
    `date_of_birth` TIMESTAMP,
    PRIMARY KEY (`guest_id`) DISABLE NOVALIDATE,
    UNIQUE (`guest_id`) DISABLE NOVALIDATE
);

drop table if exists `apartment_rentals`.`Apartment_Bookings`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Apartment_Bookings` (
    `apt_booking_id` INT NOT NULL,
    `apt_id` INT,
    `guest_id` INT NOT NULL,
    `booking_status_code` CHAR(15) NOT NULL,
    `booking_start_date` TIMESTAMP,
    `booking_end_date` TIMESTAMP,
    PRIMARY KEY (`apt_booking_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`guest_id`) REFERENCES `apartment_rentals`.`Guests` (`guest_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`apt_id`) REFERENCES `apartment_rentals`.`Apartments` (`apt_id`) DISABLE NOVALIDATE,
    UNIQUE (`apt_booking_id`) DISABLE NOVALIDATE
);

drop table if exists `apartment_rentals`.`View_Unit_Status`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`View_Unit_Status` (
    `apt_id` INT,
    `apt_booking_id` INT,
    `status_date` TIMESTAMP NOT NULL,
    `available_yn` BOOLEAN,
    PRIMARY KEY (`status_date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`apt_booking_id`) REFERENCES `apartment_rentals`.`Apartment_Bookings` (`apt_booking_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`apt_id`) REFERENCES `apartment_rentals`.`Apartments` (`apt_id`) DISABLE NOVALIDATE
);
