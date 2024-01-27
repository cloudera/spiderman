drop table if exists `dog_kennels`.`Breeds`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Breeds` (
    `breed_code` STRING,
    `breed_name` STRING,
    PRIMARY KEY (`breed_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Breeds.csv' INTO TABLE `dog_kennels`.`Breeds`;


drop table if exists `dog_kennels`.`Charges`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Charges` (
    `charge_id` INT,
    `charge_type` STRING,
    `charge_amount` DECIMAL(19,4),
    PRIMARY KEY (`charge_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Charges.csv' INTO TABLE `dog_kennels`.`Charges`;


drop table if exists `dog_kennels`.`Sizes`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Sizes` (
    `size_code` STRING,
    `size_description` STRING,
    PRIMARY KEY (`size_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Sizes.csv' INTO TABLE `dog_kennels`.`Sizes`;


drop table if exists `dog_kennels`.`Treatment_Types`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Treatment_Types` (
    `treatment_type_code` STRING,
    `treatment_type_description` STRING,
    PRIMARY KEY (`treatment_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Treatment_Types.csv' INTO TABLE `dog_kennels`.`Treatment_Types`;


drop table if exists `dog_kennels`.`Owners`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Owners` (
    `owner_id` INT,
    `first_name` STRING,
    `last_name` STRING,
    `street` STRING,
    `city` STRING,
    `state` STRING,
    `zip_code` STRING,
    `email_address` STRING,
    `home_phone` STRING,
    `cell_number` STRING,
    PRIMARY KEY (`owner_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Owners.csv' INTO TABLE `dog_kennels`.`Owners`;


drop table if exists `dog_kennels`.`Dogs`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Dogs` (
    `dog_id` INT,
    `owner_id` INT NOT NULL,
    `abandoned_yn` STRING,
    `breed_code` STRING NOT NULL,
    `size_code` STRING NOT NULL,
    `name` STRING,
    `age` STRING,
    `date_of_birth` TIMESTAMP,
    `gender` STRING,
    `weight` STRING,
    `date_arrived` TIMESTAMP,
    `date_adopted` TIMESTAMP,
    `date_departed` TIMESTAMP,
    PRIMARY KEY (`dog_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`owner_id`) REFERENCES `dog_kennels`.`Owners` (`owner_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`size_code`) REFERENCES `dog_kennels`.`Sizes` (`size_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`breed_code`) REFERENCES `dog_kennels`.`Breeds` (`breed_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Dogs.csv' INTO TABLE `dog_kennels`.`Dogs`;


drop table if exists `dog_kennels`.`Professionals`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Professionals` (
    `professional_id` INT,
    `role_code` STRING NOT NULL,
    `first_name` STRING,
    `street` STRING,
    `city` STRING,
    `state` STRING,
    `zip_code` STRING,
    `last_name` STRING,
    `email_address` STRING,
    `home_phone` STRING,
    `cell_number` STRING,
    PRIMARY KEY (`professional_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Professionals.csv' INTO TABLE `dog_kennels`.`Professionals`;


drop table if exists `dog_kennels`.`Treatments`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Treatments` (
    `treatment_id` INT,
    `dog_id` INT NOT NULL,
    `professional_id` INT NOT NULL,
    `treatment_type_code` STRING NOT NULL,
    `date_of_treatment` TIMESTAMP,
    `cost_of_treatment` DECIMAL(19,4),
    PRIMARY KEY (`treatment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dog_id`) REFERENCES `dog_kennels`.`Dogs` (`dog_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`professional_id`) REFERENCES `dog_kennels`.`Professionals` (`professional_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`treatment_type_code`) REFERENCES `dog_kennels`.`Treatment_Types` (`treatment_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Treatments.csv' INTO TABLE `dog_kennels`.`Treatments`;

