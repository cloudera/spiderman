drop table if exists `car_1`.`continents`;
CREATE TABLE IF NOT EXISTS `car_1`.`continents` (
    `ContId` INT,
    `Continent` STRING,
    PRIMARY KEY (`ContId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/continents.csv' INTO TABLE `car_1`.`continents`;


drop table if exists `car_1`.`countries`;
CREATE TABLE IF NOT EXISTS `car_1`.`countries` (
    `CountryId` INT,
    `CountryName` STRING,
    `Continent` INT,
    PRIMARY KEY (`CountryId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Continent`) REFERENCES `car_1`.`continents` (`ContId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/countries.csv' INTO TABLE `car_1`.`countries`;


drop table if exists `car_1`.`car_makers`;
CREATE TABLE IF NOT EXISTS `car_1`.`car_makers` (
    `Id` INT,
    `Maker` STRING,
    `FullName` STRING,
    `Country` INT,
    PRIMARY KEY (`Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Country`) REFERENCES `car_1`.`countries` (`CountryId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/car_makers.csv' INTO TABLE `car_1`.`car_makers`;


drop table if exists `car_1`.`model_list`;
CREATE TABLE IF NOT EXISTS `car_1`.`model_list` (
    `ModelId` INT,
    `Maker` INT,
    `Model` STRING,
    PRIMARY KEY (`ModelId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Maker`) REFERENCES `car_1`.`car_makers` (`Id`) DISABLE NOVALIDATE,
    UNIQUE (`Model`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/model_list.csv' INTO TABLE `car_1`.`model_list`;


drop table if exists `car_1`.`car_names`;
CREATE TABLE IF NOT EXISTS `car_1`.`car_names` (
    `MakeId` INT,
    `Model` STRING,
    `Make` STRING,
    PRIMARY KEY (`MakeId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Model`) REFERENCES `car_1`.`model_list` (`Model`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/car_names.csv' INTO TABLE `car_1`.`car_names`;


drop table if exists `car_1`.`cars_data`;
CREATE TABLE IF NOT EXISTS `car_1`.`cars_data` (
    `Id` INT,
    `MPG` STRING,
    `Cylinders` INT,
    `Edispl` REAL,
    `Horsepower` STRING,
    `Weight` INT,
    `Accelerate` REAL,
    `Year` INT,
    PRIMARY KEY (`Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Id`) REFERENCES `car_1`.`car_names` (`MakeId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/cars_data.csv' INTO TABLE `car_1`.`cars_data`;

