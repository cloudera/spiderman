drop table if exists `company_office`.`buildings`;
CREATE TABLE IF NOT EXISTS `company_office`.`buildings` (
    `id` INT,
    `name` STRING,
    `City` STRING,
    `Height` INT,
    `Stories` INT,
    `Status` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_office/data/buildings.csv' INTO TABLE `company_office`.`buildings`;


drop table if exists `company_office`.`Companies`;
CREATE TABLE IF NOT EXISTS `company_office`.`Companies` (
    `id` INT,
    `name` STRING,
    `Headquarters` STRING,
    `Industry` STRING,
    `Sales_billion` REAL,
    `Profits_billion` REAL,
    `Assets_billion` REAL,
    `Market_Value_billion` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_office/data/Companies.csv' INTO TABLE `company_office`.`Companies`;


drop table if exists `company_office`.`Office_locations`;
CREATE TABLE IF NOT EXISTS `company_office`.`Office_locations` (
    `building_id` INT,
    `company_id` INT,
    `move_in_year` INT,
    PRIMARY KEY (`building_id`, `company_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`company_id`) REFERENCES `company_office`.`Companies` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building_id`) REFERENCES `company_office`.`buildings` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_office/data/Office_locations.csv' INTO TABLE `company_office`.`Office_locations`;

