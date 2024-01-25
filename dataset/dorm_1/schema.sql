drop table if exists `dorm_1`.`Student`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Student.csv' INTO TABLE `dorm_1`.`Student`;


drop table if exists `dorm_1`.`Dorm`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Dorm` (
    `dormid` INT,
    `dorm_name` STRING,
    `student_capacity` INT,
    `gender` STRING,
    UNIQUE (`dormid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Dorm.csv' INTO TABLE `dorm_1`.`Dorm`;


drop table if exists `dorm_1`.`Dorm_amenity`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Dorm_amenity` (
    `amenid` INT,
    `amenity_name` STRING,
    UNIQUE (`amenid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Dorm_amenity.csv' INTO TABLE `dorm_1`.`Dorm_amenity`;


drop table if exists `dorm_1`.`Has_amenity`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Has_amenity` (
    `dormid` INT,
    `amenid` INT,
    FOREIGN KEY (`amenid`) REFERENCES `dorm_1`.`Dorm_amenity` (`amenid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dormid`) REFERENCES `dorm_1`.`Dorm` (`dormid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Has_amenity.csv' INTO TABLE `dorm_1`.`Has_amenity`;


drop table if exists `dorm_1`.`Lives_in`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Lives_in` (
    `stuid` INT,
    `dormid` INT,
    `room_number` INT,
    FOREIGN KEY (`dormid`) REFERENCES `dorm_1`.`Dorm` (`dormid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`stuid`) REFERENCES `dorm_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Lives_in.csv' INTO TABLE `dorm_1`.`Lives_in`;

