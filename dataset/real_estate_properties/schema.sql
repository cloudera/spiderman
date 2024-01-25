drop table if exists `real_estate_properties`.`Ref_Feature_Types`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Ref_Feature_Types` (
    `feature_type_code` STRING,
    `feature_type_name` STRING,
    PRIMARY KEY (`feature_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Ref_Feature_Types.csv' INTO TABLE `real_estate_properties`.`Ref_Feature_Types`;


drop table if exists `real_estate_properties`.`Ref_Property_Types`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Ref_Property_Types` (
    `property_type_code` STRING,
    `property_type_description` STRING,
    PRIMARY KEY (`property_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Ref_Property_Types.csv' INTO TABLE `real_estate_properties`.`Ref_Property_Types`;


drop table if exists `real_estate_properties`.`Other_Available_Features`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Other_Available_Features` (
    `feature_id` INT,
    `feature_type_code` STRING NOT NULL,
    `feature_name` STRING,
    `feature_description` STRING,
    PRIMARY KEY (`feature_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`feature_type_code`) REFERENCES `real_estate_properties`.`Ref_Feature_Types` (`feature_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Other_Available_Features.csv' INTO TABLE `real_estate_properties`.`Other_Available_Features`;


drop table if exists `real_estate_properties`.`Properties`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Properties` (
    `property_id` INT,
    `property_type_code` STRING NOT NULL,
    `date_on_market` TIMESTAMP,
    `date_sold` TIMESTAMP,
    `property_name` STRING,
    `property_address` STRING,
    `room_count` INT,
    `vendor_requested_price` DECIMAL(19,4),
    `buyer_offered_price` DECIMAL(19,4),
    `agreed_selling_price` DECIMAL(19,4),
    `apt_feature_1` STRING,
    `apt_feature_2` STRING,
    `apt_feature_3` STRING,
    `fld_feature_1` STRING,
    `fld_feature_2` STRING,
    `fld_feature_3` STRING,
    `hse_feature_1` STRING,
    `hse_feature_2` STRING,
    `hse_feature_3` STRING,
    `oth_feature_1` STRING,
    `oth_feature_2` STRING,
    `oth_feature_3` STRING,
    `shp_feature_1` STRING,
    `shp_feature_2` STRING,
    `shp_feature_3` STRING,
    `other_property_details` STRING,
    PRIMARY KEY (`property_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`property_type_code`) REFERENCES `real_estate_properties`.`Ref_Property_Types` (`property_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Properties.csv' INTO TABLE `real_estate_properties`.`Properties`;


drop table if exists `real_estate_properties`.`Other_Property_Features`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Other_Property_Features` (
    `property_id` INT NOT NULL,
    `feature_id` INT NOT NULL,
    `property_feature_description` STRING,
    FOREIGN KEY (`property_id`) REFERENCES `real_estate_properties`.`Properties` (`property_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`feature_id`) REFERENCES `real_estate_properties`.`Other_Available_Features` (`feature_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Other_Property_Features.csv' INTO TABLE `real_estate_properties`.`Other_Property_Features`;

