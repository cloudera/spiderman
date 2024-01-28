CREATE DATABASE IF NOT EXISTS `coffee_shop`;

drop table if exists `coffee_shop`.`shop`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`shop` (
    `Shop_ID` INT,
    `Address` STRING,
    `Num_of_staff` STRING,
    `Score` DOUBLE,
    `Open_Year` STRING,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE
);

drop table if exists `coffee_shop`.`member`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`member` (
    `Member_ID` INT,
    `Name` STRING,
    `Membership_card` STRING,
    `Age` INT,
    `Time_of_purchase` INT,
    `Level_of_membership` INT,
    `Address` STRING,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE
);

drop table if exists `coffee_shop`.`happy_hour`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`happy_hour` (
    `HH_ID` INT,
    `Shop_ID` INT,
    `Month` STRING,
    `Num_of_shaff_in_charge` INT,
    PRIMARY KEY (`HH_ID`, `Shop_ID`, `Month`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `coffee_shop`.`shop` (`Shop_ID`) DISABLE NOVALIDATE
);

drop table if exists `coffee_shop`.`happy_hour_member`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`happy_hour_member` (
    `HH_ID` INT,
    `Member_ID` INT,
    `Total_amount` DOUBLE,
    PRIMARY KEY (`HH_ID`, `Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `coffee_shop`.`member` (`Member_ID`) DISABLE NOVALIDATE
);
