drop table if exists `manufactory_1`.`Manufacturers`;
CREATE TABLE IF NOT EXISTS `manufactory_1`.`Manufacturers` (
    `Code` INT,
    `Name` STRING NOT NULL,
    `Headquarter` STRING NOT NULL,
    `Founder` STRING NOT NULL,
    `Revenue` REAL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufactory_1/data/Manufacturers.csv' INTO TABLE `manufactory_1`.`Manufacturers`;


drop table if exists `manufactory_1`.`Products`;
CREATE TABLE IF NOT EXISTS `manufactory_1`.`Products` (
    `Code` INT,
    `Name` STRING NOT NULL,
    `Price` DECIMAL NOT NULL,
    `Manufacturer` INT NOT NULL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Manufacturer`) REFERENCES `manufactory_1`.`Manufacturers` (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufactory_1/data/Products.csv' INTO TABLE `manufactory_1`.`Products`;

