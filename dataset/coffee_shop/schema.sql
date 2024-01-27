CREATE DATABASE IF NOT EXISTS `coffee_shop`;

drop table if exists `coffee_shop`.`shop`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`shop` (
    `Shop_ID` INT,
    `Address` STRING,
    `Num_of_staff` STRING,
    `Score` REAL,
    `Open_Year` STRING,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/coffee_shop/data/shop.csv' INTO TABLE `coffee_shop`.`shop`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/coffee_shop/data/member.csv' INTO TABLE `coffee_shop`.`member`;


drop table if exists `coffee_shop`.`happy_hour`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`happy_hour` (
    `HH_ID` INT,
    `Shop_ID` INT,
    `Month` STRING,
    `Num_of_shaff_in_charge` INT,
    PRIMARY KEY (`HH_ID`, `Shop_ID`, `Month`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `coffee_shop`.`shop` (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/coffee_shop/data/happy_hour.csv' INTO TABLE `coffee_shop`.`happy_hour`;


drop table if exists `coffee_shop`.`happy_hour_member`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`happy_hour_member` (
    `HH_ID` INT,
    `Member_ID` INT,
    `Total_amount` REAL,
    PRIMARY KEY (`HH_ID`, `Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `coffee_shop`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/coffee_shop/data/happy_hour_member.csv' INTO TABLE `coffee_shop`.`happy_hour_member`;

