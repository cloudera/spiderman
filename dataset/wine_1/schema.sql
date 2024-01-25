drop table if exists `wine_1`.`grapes`;
CREATE TABLE IF NOT EXISTS `wine_1`.`grapes` (
    `ID` INT,
    `Grape` STRING,
    `Color` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    UNIQUE (`Grape`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wine_1/data/grapes.csv' INTO TABLE `wine_1`.`grapes`;


drop table if exists `wine_1`.`appellations`;
CREATE TABLE IF NOT EXISTS `wine_1`.`appellations` (
    `No` INT,
    `Appelation` STRING,
    `County` STRING,
    `State` STRING,
    `Area` STRING,
    `isAVA` STRING,
    PRIMARY KEY (`No`) DISABLE NOVALIDATE,
    UNIQUE (`Appelation`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wine_1/data/appellations.csv' INTO TABLE `wine_1`.`appellations`;


drop table if exists `wine_1`.`wine`;
CREATE TABLE IF NOT EXISTS `wine_1`.`wine` (
    `No` INT,
    `Grape` STRING,
    `Winery` STRING,
    `Appelation` STRING,
    `State` STRING,
    `Name` STRING,
    `Year` INT,
    `Price` INT,
    `Score` INT,
    `Cases` INT,
    `Drink` STRING,
    FOREIGN KEY (`Appelation`) REFERENCES `wine_1`.`appellations` (`Appelation`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Grape`) REFERENCES `wine_1`.`grapes` (`Grape`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wine_1/data/wine.csv' INTO TABLE `wine_1`.`wine`;

