drop table if exists `protein_institute`.`building`;
CREATE TABLE IF NOT EXISTS `protein_institute`.`building` (
    `building_id` STRING,
    `Name` STRING,
    `Street_address` STRING,
    `Years_as_tallest` STRING,
    `Height_feet` INT,
    `Floors` INT,
    PRIMARY KEY (`building_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/protein_institute/data/building.csv' INTO TABLE `protein_institute`.`building`;


drop table if exists `protein_institute`.`Institution`;
CREATE TABLE IF NOT EXISTS `protein_institute`.`Institution` (
    `Institution_id` STRING,
    `Institution` STRING,
    `Location` STRING,
    `Founded` REAL,
    `Type` STRING,
    `Enrollment` INT,
    `Team` STRING,
    `Primary_Conference` STRING,
    `building_id` STRING,
    PRIMARY KEY (`Institution_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building_id`) REFERENCES `protein_institute`.`building` (`building_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/protein_institute/data/Institution.csv' INTO TABLE `protein_institute`.`Institution`;


drop table if exists `protein_institute`.`protein`;
CREATE TABLE IF NOT EXISTS `protein_institute`.`protein` (
    `common_name` STRING,
    `protein_name` STRING,
    `divergence_from_human_lineage` REAL,
    `accession_number` STRING,
    `sequence_length` REAL,
    `sequence_identity_to_human_protein` STRING,
    `Institution_id` STRING,
    PRIMARY KEY (`common_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Institution_id`) REFERENCES `protein_institute`.`Institution` (`Institution_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/protein_institute/data/protein.csv' INTO TABLE `protein_institute`.`protein`;

