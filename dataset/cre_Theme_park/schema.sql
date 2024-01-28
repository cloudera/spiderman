CREATE DATABASE IF NOT EXISTS `cre_Theme_park`;

drop table if exists `cre_Theme_park`.`Ref_Hotel_Star_Ratings`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Ref_Hotel_Star_Ratings` (
    `star_rating_code` CHAR(15) NOT NULL,
    `star_rating_description` STRING,
    PRIMARY KEY (`star_rating_code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Locations`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Locations` (
    `Location_ID` INT NOT NULL,
    `Location_Name` STRING,
    `Address` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Location_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Ref_Attraction_Types`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Ref_Attraction_Types` (
    `Attraction_Type_Code` CHAR(15) NOT NULL,
    `Attraction_Type_Description` STRING,
    PRIMARY KEY (`Attraction_Type_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Visitors`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Visitors` (
    `Tourist_ID` INT NOT NULL,
    `Tourist_Details` STRING,
    PRIMARY KEY (`Tourist_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Tourist_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Features`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Features` (
    `Feature_ID` INT NOT NULL,
    `Feature_Details` STRING,
    PRIMARY KEY (`Feature_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Hotels`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Hotels` (
    `hotel_id` INT NOT NULL,
    `star_rating_code` CHAR(15) NOT NULL,
    `pets_allowed_yn` CHAR(1),
    `price_range` DOUBLE,
    `other_hotel_details` STRING,
    PRIMARY KEY (`hotel_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`star_rating_code`) REFERENCES `cre_Theme_park`.`Ref_Hotel_Star_Ratings` (`star_rating_code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Tourist_Attractions`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Tourist_Attractions` (
    `Tourist_Attraction_ID` INT NOT NULL,
    `Attraction_Type_Code` CHAR(15) NOT NULL,
    `Location_ID` INT NOT NULL,
    `How_to_Get_There` STRING,
    `Name` STRING,
    `Description` STRING,
    `Opening_Hours` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Tourist_Attraction_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Attraction_Type_Code`) REFERENCES `cre_Theme_park`.`Ref_Attraction_Types` (`Attraction_Type_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Location_ID`) REFERENCES `cre_Theme_park`.`Locations` (`Location_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Street_Markets`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Street_Markets` (
    `Market_ID` INT NOT NULL,
    `Market_Details` STRING,
    PRIMARY KEY (`Market_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Market_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Shops`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Shops` (
    `Shop_ID` INT NOT NULL,
    `Shop_Details` STRING,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Museums`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Museums` (
    `Museum_ID` INT NOT NULL,
    `Museum_Details` STRING,
    PRIMARY KEY (`Museum_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Museum_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Royal_Family`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Royal_Family` (
    `Royal_Family_ID` INT NOT NULL,
    `Royal_Family_Details` STRING,
    PRIMARY KEY (`Royal_Family_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Royal_Family_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Theme_Parks`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Theme_Parks` (
    `Theme_Park_ID` INT NOT NULL,
    `Theme_Park_Details` STRING,
    PRIMARY KEY (`Theme_Park_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Theme_Park_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Visits`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Visits` (
    `Visit_ID` INT NOT NULL,
    `Tourist_Attraction_ID` INT NOT NULL,
    `Tourist_ID` INT NOT NULL,
    `Visit_Date` TIMESTAMP NOT NULL,
    `Visit_Details` STRING NOT NULL,
    PRIMARY KEY (`Visit_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_ID`) REFERENCES `cre_Theme_park`.`Visitors` (`Tourist_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_Attraction_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Photos`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Photos` (
    `Photo_ID` INT NOT NULL,
    `Tourist_Attraction_ID` INT NOT NULL,
    `Name` STRING,
    `Description` STRING,
    `Filename` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Photo_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_Attraction_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Staff`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Staff` (
    `Staff_ID` INT NOT NULL,
    `Tourist_Attraction_ID` INT NOT NULL,
    `Name` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Staff_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_Attraction_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Theme_park`.`Tourist_Attraction_Features`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Tourist_Attraction_Features` (
    `Tourist_Attraction_ID` INT NOT NULL,
    `Feature_ID` INT NOT NULL,
    PRIMARY KEY (`Tourist_Attraction_ID`, `Feature_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Feature_ID`) REFERENCES `cre_Theme_park`.`Features` (`Feature_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_Attraction_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
);
