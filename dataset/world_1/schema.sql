CREATE DATABASE IF NOT EXISTS `world_1`;

drop table if exists `world_1`.`country`;
CREATE TABLE IF NOT EXISTS `world_1`.`country` (
    `Code` CHAR(3) NOT NULL,
    `Name` CHAR(52) NOT NULL,
    `Continent` STRING NOT NULL,
    `Region` CHAR(26) NOT NULL,
    `SurfaceArea` DECIMAL(10,2) NOT NULL,
    `IndepYear` INT,
    `Population` INT NOT NULL,
    `LifeExpectancy` DECIMAL(3,1),
    `GNP` DECIMAL(10,2),
    `GNPOld` DECIMAL(10,2),
    `LocalName` CHAR(45) NOT NULL,
    `GovernmentForm` CHAR(45) NOT NULL,
    `HeadOfState` CHAR(60),
    `Capital` INT,
    `Code2` CHAR(2) NOT NULL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/world_1/data/country.csv' INTO TABLE `world_1`.`country`;


drop table if exists `world_1`.`city`;
CREATE TABLE IF NOT EXISTS `world_1`.`city` (
    `ID` INT NOT NULL,
    `Name` CHAR(35) NOT NULL,
    `CountryCode` CHAR(3) NOT NULL,
    `District` CHAR(20) NOT NULL,
    `Population` INT NOT NULL,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CountryCode`) REFERENCES `world_1`.`country` (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/world_1/data/city.csv' INTO TABLE `world_1`.`city`;


drop table if exists `world_1`.`countrylanguage`;
CREATE TABLE IF NOT EXISTS `world_1`.`countrylanguage` (
    `CountryCode` CHAR(3) NOT NULL,
    `Language` CHAR(30) NOT NULL,
    `IsOfficial` STRING NOT NULL,
    `Percentage` DECIMAL(4,1) NOT NULL,
    PRIMARY KEY (`CountryCode`, `Language`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CountryCode`) REFERENCES `world_1`.`country` (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/world_1/data/countrylanguage.csv' INTO TABLE `world_1`.`countrylanguage`;

