drop table if exists `shop_membership`.`member`;
CREATE TABLE IF NOT EXISTS `shop_membership`.`member` (
    `Member_ID` INT,
    `Card_Number` STRING,
    `Name` STRING,
    `Hometown` STRING,
    `Level` INT,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/shop_membership/data/member.csv' INTO TABLE `shop_membership`.`member`;


drop table if exists `shop_membership`.`branch`;
CREATE TABLE IF NOT EXISTS `shop_membership`.`branch` (
    `Branch_ID` INT,
    `Name` STRING,
    `Open_year` STRING,
    `Address_road` STRING,
    `City` STRING,
    `membership_amount` STRING,
    PRIMARY KEY (`Branch_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/shop_membership/data/branch.csv' INTO TABLE `shop_membership`.`branch`;


drop table if exists `shop_membership`.`membership_register_branch`;
CREATE TABLE IF NOT EXISTS `shop_membership`.`membership_register_branch` (
    `Member_ID` INT,
    `Branch_ID` INT,
    `Register_Year` STRING,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Branch_ID`) REFERENCES `shop_membership`.`branch` (`Branch_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `shop_membership`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/shop_membership/data/membership_register_branch.csv' INTO TABLE `shop_membership`.`membership_register_branch`;


drop table if exists `shop_membership`.`purchase`;
CREATE TABLE IF NOT EXISTS `shop_membership`.`purchase` (
    `Member_ID` INT,
    `Branch_ID` INT,
    `Year` STRING,
    `Total_pounds` REAL,
    PRIMARY KEY (`Member_ID`, `Branch_ID`, `Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Branch_ID`) REFERENCES `shop_membership`.`branch` (`Branch_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `shop_membership`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/shop_membership/data/purchase.csv' INTO TABLE `shop_membership`.`purchase`;

