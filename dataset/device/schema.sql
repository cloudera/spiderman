drop table if exists `device`.`device`;
CREATE TABLE IF NOT EXISTS `device`.`device` (
    `Device_ID` INT,
    `Device` STRING,
    `Carrier` STRING,
    `Package_Version` STRING,
    `Applications` STRING,
    `Software_Platform` STRING,
    PRIMARY KEY (`Device_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/device/data/device.csv' INTO TABLE `device`.`device`;


drop table if exists `device`.`shop`;
CREATE TABLE IF NOT EXISTS `device`.`shop` (
    `Shop_ID` INT,
    `Shop_Name` STRING,
    `Location` STRING,
    `Open_Date` STRING,
    `Open_Year` INT,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/device/data/shop.csv' INTO TABLE `device`.`shop`;


drop table if exists `device`.`stock`;
CREATE TABLE IF NOT EXISTS `device`.`stock` (
    `Shop_ID` INT,
    `Device_ID` INT,
    `Quantity` INT,
    PRIMARY KEY (`Shop_ID`, `Device_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Device_ID`) REFERENCES `device`.`device` (`Device_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `device`.`shop` (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/device/data/stock.csv' INTO TABLE `device`.`stock`;

