CREATE DATABASE IF NOT EXISTS `aircraft`;

drop table if exists `aircraft`.`pilot`;
CREATE TABLE IF NOT EXISTS `aircraft`.`pilot` (
    `Pilot_Id` INT NOT NULL,
    `Name` STRING NOT NULL,
    `Age` INT NOT NULL,
    PRIMARY KEY (`Pilot_Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/pilot.csv' INTO TABLE `aircraft`.`pilot`;


drop table if exists `aircraft`.`aircraft`;
CREATE TABLE IF NOT EXISTS `aircraft`.`aircraft` (
    `Aircraft_ID` INT NOT NULL,
    `Aircraft` STRING NOT NULL,
    `Description` STRING NOT NULL,
    `Max_Gross_Weight` STRING NOT NULL,
    `Total_disk_area` STRING NOT NULL,
    `Max_disk_Loading` STRING NOT NULL,
    PRIMARY KEY (`Aircraft_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/aircraft.csv' INTO TABLE `aircraft`.`aircraft`;


drop table if exists `aircraft`.`match`;
CREATE TABLE IF NOT EXISTS `aircraft`.`match` (
    `Round` REAL,
    `Location` STRING,
    `Country` STRING,
    `Date` STRING,
    `Fastest_Qualifying` STRING,
    `Winning_Pilot` INT,
    `Winning_Aircraft` INT,
    PRIMARY KEY (`Round`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Winning_Pilot`) REFERENCES `aircraft`.`pilot` (`Pilot_Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Winning_Aircraft`) REFERENCES `aircraft`.`aircraft` (`Aircraft_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/match.csv' INTO TABLE `aircraft`.`match`;


drop table if exists `aircraft`.`airport`;
CREATE TABLE IF NOT EXISTS `aircraft`.`airport` (
    `Airport_ID` INT,
    `Airport_Name` STRING,
    `Total_Passengers` REAL,
    `%_Change_2007` STRING,
    `International_Passengers` REAL,
    `Domestic_Passengers` REAL,
    `Transit_Passengers` REAL,
    `Aircraft_Movements` REAL,
    `Freight_Metric_Tonnes` REAL,
    PRIMARY KEY (`Airport_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/airport.csv' INTO TABLE `aircraft`.`airport`;


drop table if exists `aircraft`.`airport_aircraft`;
CREATE TABLE IF NOT EXISTS `aircraft`.`airport_aircraft` (
    `ID` INT,
    `Airport_ID` INT,
    `Aircraft_ID` INT,
    PRIMARY KEY (`Airport_ID`, `Aircraft_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Aircraft_ID`) REFERENCES `aircraft`.`aircraft` (`Aircraft_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Airport_ID`) REFERENCES `aircraft`.`airport` (`Airport_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/airport_aircraft.csv' INTO TABLE `aircraft`.`airport_aircraft`;

